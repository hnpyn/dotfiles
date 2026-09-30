local reloadTimer = nil

-- Register before require/start. A module error must still leave reload working.
-- Hammerspoon can collect a watcher that is only stored in a local after init.lua returns.
configWatcher = hs.pathwatcher.new(hs.configdir, function(files)
  local changed = false
  for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" then
      changed = true
      break
    end
  end
  if not changed then
    return
  end
  if reloadTimer then
    reloadTimer:stop()
  end
  reloadTimer = hs.timer.doAfter(0.2, function()
    reloadTimer = nil
    hs.reload()
  end)
end)
configWatcher:start()

local launcher = require("launcher")
local focus = require("focus")
local windows = require("windows")

launcher.start()
focus.start({ paused = launcher.isOpen })
windows.start()
