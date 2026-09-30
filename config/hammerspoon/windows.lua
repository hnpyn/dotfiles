-- Globe+Control+u/i/j/k places the focused window in a screen corner.
-- hs.hotkey cannot bind the Globe key, so this watches keyDown and keyUp for the fn flag.
-- u i
-- j k

local windows = {}

local GAP = 0

local corners = {
  [hs.keycodes.map.u] = { 0, 0 },
  [hs.keycodes.map.i] = { 1, 0 },
  [hs.keycodes.map.j] = { 0, 1 },
  [hs.keycodes.map.k] = { 1, 1 },
}

local eventTap = nil
local placeTimer = nil

local function quarter(frame, col, row)
  local w = (frame.w - GAP * 3) / 2
  local h = (frame.h - GAP * 3) / 2
  return {
    x = frame.x + GAP + col * (w + GAP),
    y = frame.y + GAP + row * (h + GAP),
    w = w,
    h = h,
  }
end

local function place(win, col, row, duration)
  local screen = win:screen()
  if not screen then
    return
  end
  win:setFrame(quarter(screen:frame(), col, row), duration)
end

local function stopPlaceTimer()
  if placeTimer then
    placeTimer:stop()
    placeTimer = nil
  end
end

-- isFullScreen() flips before the exit animation finishes, and that animation
-- can put the old frame back. Wait until the window is actually windowed,
-- then keep applying the corner until the animation has had time to end.
-- Retries run every 0.1s, so they skip hs.window's own 0.2s animation.
local function placeAfterFullscreen(win, col, row)
  local deadline = hs.timer.secondsSinceEpoch() + 2
  local windowedAt = nil
  local function attempt()
    placeTimer = nil
    if not win:isVisible() then
      return
    end
    local now = hs.timer.secondsSinceEpoch()
    if win:isFullScreen() then
      if now < deadline then
        placeTimer = hs.timer.doAfter(0.1, attempt)
      end
      return
    end
    place(win, col, row, 0)
    windowedAt = windowedAt or now
    if now < windowedAt + 0.5 and now < deadline then
      placeTimer = hs.timer.doAfter(0.1, attempt)
    end
  end
  placeTimer = hs.timer.doAfter(0.1, attempt)
end

local function placeFocused(col, row)
  local win = hs.window.focusedWindow()
  if not win then
    return
  end
  stopPlaceTimer()
  if win:isFullScreen() then
    win:setFullScreen(false)
    placeAfterFullscreen(win, col, row)
    return
  end
  place(win, col, row)
end

local function globeCtrlOnly(flags)
  return flags.fn and flags.ctrl and not flags.cmd and not flags.alt and not flags.shift
end

function windows.start()
  local keyDown = hs.eventtap.event.types.keyDown
  local keyUp = hs.eventtap.event.types.keyUp
  local swallowed = {}
  eventTap = hs.eventtap.new({ keyDown, keyUp }, function(event)
    local keyCode = event:getKeyCode()
    if event:getType() == keyUp then
      if not swallowed[keyCode] then
        return false
      end
      swallowed[keyCode] = nil
      return true
    end
    local flags = event:getFlags()
    if not globeCtrlOnly(flags) or not corners[keyCode] then
      return false
    end
    swallowed[keyCode] = true
    local repeatProp = hs.eventtap.event.properties.keyboardEventAutorepeat
    if event:getProperty(repeatProp) ~= 1 then
      local corner = corners[keyCode]
      placeFocused(corner[1], corner[2])
    end
    return true
  end)
  eventTap:start()
end

return windows
