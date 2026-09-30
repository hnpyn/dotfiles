-- Option+Space chooser for apps and custom actions.
-- Choice tables survive only as plain values, so selection maps id back to an
-- action or a bundle ID.

local launcher = {}

local RESULT_LIMIT = 80

local APP_ROOTS = {
  "/Applications",
  "/System/Applications",
  "/System/Applications/Utilities",
  os.getenv("HOME") .. "/Applications",
}

local actions = {
  {
    id = "action:ntty-new",
    text = "新建 ntty",
    subText = "新开一个终端窗口",
    keywords = "ntty terminal term 终端 新建",
    imageBundleID = "dev.n.ntty",
    run = function()
      hs.task.new("/usr/bin/open", nil, { "-na", "ntty" }):start()
    end,
  },
}

local apps = {}
local runningSet = {}
local chooser = nil
local hotkey = nil
local pendingTimer = nil
local scanTimer = nil
local dirWatchers = {}

local function trim(text)
  return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function splitChars(text)
  local list = {}
  for char in text:gmatch(utf8.charpattern) do
    list[#list + 1] = char
  end
  return list
end

-- Subsequence match over UTF-8 characters, so a CJK query cannot match stray bytes.
-- Consecutive hits and word starts score higher.
local function fuzzyScore(query, text)
  if query == "" then
    return 0
  end
  local wanted = splitChars(query:lower())
  local queryIndex = 1
  local score = 0
  local previous = nil
  local run = 0
  local i = 0
  local before = nil
  for char in text:lower():gmatch(utf8.charpattern) do
    i = i + 1
    if char == wanted[queryIndex] then
      local bonus = 1
      if previous and i == previous + 1 then
        run = run + 1
        bonus = bonus + run * 3
      else
        run = 0
      end
      if not before or before:match("^[%s%p]$") then
        bonus = bonus + 6
      end
      score = score + bonus
      previous = i
      queryIndex = queryIndex + 1
      if queryIndex > #wanted then
        return score
      end
    end
    before = char
  end
  return nil
end

local function present(item, subText)
  local choice = {
    text = item.text,
    id = item.id,
  }
  if subText and subText ~= "" then
    choice.subText = subText
  end
  if item.image then
    choice.image = item.image
  end
  return choice
end

local function runningBundleIDs()
  local running = {}
  for _, app in ipairs(hs.application.runningApplications()) do
    local bundleID = app:bundleID()
    if bundleID then
      running[bundleID] = true
    end
  end
  return running
end

local function byText(a, b)
  return a.text:lower() < b.text:lower()
end

local function isDirectory(path)
  local attributes = hs.fs.attributes(path)
  return attributes ~= nil and attributes.mode == "directory"
end

local function addApp(path, file, intoApps, seen)
  local info = hs.application.infoForBundlePath(path)
  local bundleID = info and info.CFBundleIdentifier
  if not bundleID or seen[bundleID] then
    return
  end
  local filename = file:gsub("%.app$", "")
  local plistName = info.CFBundleDisplayName or info.CFBundleName or filename
  -- Finder's localized name, e.g. 计算器 for Calculator.app.
  local displayName = hs.fs.displayName(path)
  local name = displayName and displayName:gsub("%.app$", "") or plistName
  intoApps[#intoApps + 1] = {
    id = bundleID,
    text = name,
    search = table.concat({ name, plistName, filename, bundleID }, " "),
    image = hs.image.imageFromAppBundle(bundleID),
  }
  seen[bundleID] = true
end

local buildChoices

local function scanApps()
  scanTimer = nil
  local nextApps = {}
  local seen = {}
  for _, root in ipairs(APP_ROOTS) do
    if isDirectory(root) then
      for file in hs.fs.dir(root) do
        if file:sub(-4) == ".app" then
          addApp(root .. "/" .. file, file, nextApps, seen)
        end
      end
    end
  end
  apps = nextApps
  if chooser:isVisible() then
    chooser:choices(buildChoices(chooser:query()))
  end
end

local function scheduleScan(delay)
  if scanTimer then
    scanTimer:stop()
  end
  scanTimer = hs.timer.doAfter(delay, scanApps)
end

local function runnerFor(id)
  for _, action in ipairs(actions) do
    if action.id == id then
      return action.run
    end
  end
  if id:match("^action:") then
    return nil
  end
  return function()
    hs.application.launchOrFocusByBundleID(id)
  end
end

function buildChoices(query)
  query = trim(query or ""):lower()
  local running = runningSet
  if query == "" then
    local choices = {}
    for _, action in ipairs(actions) do
      choices[#choices + 1] = present(action, action.subText)
    end
    local runningApps = {}
    local otherApps = {}
    for _, app in ipairs(apps) do
      if running[app.id] then
        runningApps[#runningApps + 1] = app
      else
        otherApps[#otherApps + 1] = app
      end
    end
    table.sort(runningApps, byText)
    table.sort(otherApps, byText)
    for _, app in ipairs(runningApps) do
      choices[#choices + 1] = present(app, "正在运行")
    end
    for _, app in ipairs(otherApps) do
      choices[#choices + 1] = present(app)
    end
    return choices
  end

  local ranked = {}
  for index, action in ipairs(actions) do
    local score = fuzzyScore(query, action.search)
    if score then
      ranked[#ranked + 1] = {
        score = score,
        index = index,
        choice = present(action, action.subText),
      }
    end
  end
  for index, app in ipairs(apps) do
    local score = fuzzyScore(query, app.search)
    if score then
      ranked[#ranked + 1] = {
        score = score,
        index = #actions + index,
        choice = present(app, running[app.id] and "正在运行" or nil),
      }
    end
  end
  table.sort(ranked, function(a, b)
    if a.score ~= b.score then
      return a.score > b.score
    end
    return a.index < b.index
  end)
  local choices = {}
  local limit = math.min(#ranked, RESULT_LIMIT)
  for i = 1, limit do
    choices[i] = ranked[i].choice
  end
  return choices
end

local function toggle()
  if chooser:isVisible() then
    chooser:hide()
    return
  end
  runningSet = runningBundleIDs()
  chooser:bgDark(hs.host.interfaceStyle() == "Dark")
  chooser:query("")
  chooser:show()
end

local function prepareActions()
  for _, action in ipairs(actions) do
    action.search = table.concat({ action.text, action.subText or "", action.keywords or "" }, " ")
    if action.imageBundleID then
      action.image = hs.image.imageFromAppBundle(action.imageBundleID)
    end
  end
end

function launcher.isOpen()
  return chooser ~= nil and chooser:isVisible()
end

function launcher.start()
  prepareActions()
  chooser = hs.chooser.new(function(choice)
    if not choice or type(choice.id) ~= "string" then
      return
    end
    local run = runnerFor(choice.id)
    if not run then
      return
    end
    -- didClose restores the previous window before this callback.
    -- Run on the next turn so the chosen app keeps focus.
    if pendingTimer then
      pendingTimer:stop()
    end
    pendingTimer = hs.timer.doAfter(0, function()
      pendingTimer = nil
      run()
    end)
  end)
  chooser:placeholderText("搜索应用或动作")
  chooser:rows(10)
  chooser:queryChangedCallback(function(query)
    chooser:choices(buildChoices(query))
  end)

  -- The repeat callback swallows key-repeat so the chooser is not toggled again.
  hotkey = hs.hotkey.bind({ "alt" }, "space", toggle, nil, function() end)
  if not hotkey then
    hs.alert.show("Option+Space 已被占用")
  end

  for _, root in ipairs(APP_ROOTS) do
    if isDirectory(root) then
      -- FSEvents is recursive. Only bundles directly under root change the index;
      -- nested helper apps are rewritten on every app update.
      local watcher = hs.pathwatcher.new(root, function(files)
        for _, file in ipairs(files) do
          if file:match("^(.*)/[^/]+%.app/?$") == root then
            scheduleScan(0.3)
            return
          end
        end
      end)
      watcher:start()
      dirWatchers[#dirWatchers + 1] = watcher
    end
  end

  scheduleScan(0)
end

return launcher
