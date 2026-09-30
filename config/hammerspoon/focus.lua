-- Focus the window under the pointer after it has stayed inside that window
-- for DWELL_SECONDS. Moving inside that window does not reset the wait.
-- The event tap only stores the pointer and arms a SAMPLE_SECONDS sample.
-- That sample reads the latest point, so the resting position is included.
--
-- AX calls block Hammerspoon's single Lua thread, keyboard taps included.
-- A lookup normally takes about a millisecond. When one is slow (a busy or
-- hung app), sampling pauses for a growing interval instead of repeating it.
--
-- Control and Fn are Loop's trigger keys; mouse buttons mean a drag is in progress.

local focus = {}

local DWELL_SECONDS = 0.4
local SAMPLE_SECONDS = 0.08
local AX_TIMEOUT_SECONDS = 0.3
local SLOW_SECONDS = 0.1
local BACKOFF_SECONDS = 0.5
local MAX_BACKOFF_SECONDS = 5

local now = hs.timer.secondsSinceEpoch

local paused = function()
  return false
end

local systemElement = nil
local eventTap = nil
local sampleTimer = nil
local dwellTimer = nil
local latestPoint = nil
local slowLookups = 0
local backoffUntil = 0
local pendingId = nil
local dwellDue = false
local settled = false

local ACCEPT_SUBROLES = {
  AXStandardWindow = true,
  AXDialog = true,
  AXSystemDialog = true,
}

local function blocked()
  if paused() then
    return true
  end
  local mods = hs.eventtap.checkKeyboardModifiers()
  local buttons = hs.eventtap.checkMouseButtons()
  return mods.ctrl or mods.fn or buttons.left or buttons.right or buttons.middle
end

-- Small non-standard windows are palettes, popovers and the like.
local function acceptable(win)
  if ACCEPT_SUBROLES[win:subrole()] then
    return true
  end
  local frame = win:frame()
  return frame.w >= 200 and frame.h >= 120
end

-- AX hit-testing skips click-through overlays such as watermark windows.
local function windowAt(point)
  local element = systemElement:elementAtPosition(point)
  if not element then
    return nil
  end
  local win = element:asHSWindow()
  if not win then
    local axWindow = element:attributeValue("AXWindow")
    win = axWindow and axWindow:asHSWindow()
  end
  if win and acceptable(win) then
    return win
  end
  return nil
end

local function reset()
  pendingId = nil
  dwellDue = false
  settled = false
  dwellTimer:stop()
end

local function armSample()
  local wait = backoffUntil - now()
  if wait > 0 then
    sampleTimer:start(wait)
  elseif not sampleTimer:running() then
    sampleTimer:start()
  end
end

local function evaluate()
  if blocked() then
    reset()
    return
  end
  if now() < backoffUntil then
    armSample()
    return
  end
  if not latestPoint then
    return
  end

  local started = now()
  local win = windowAt(latestPoint)
  if now() - started >= SLOW_SECONDS then
    slowLookups = slowLookups + 1
    backoffUntil = now() + math.min(BACKOFF_SECONDS * slowLookups, MAX_BACKOFF_SECONDS)
  else
    slowLookups = 0
  end

  if not win then
    reset()
    return
  end
  local id = win:id()
  if id ~= pendingId then
    pendingId = id
    dwellDue = false
    settled = false
    dwellTimer:start()
    return
  end
  -- settled stays true for this window: after a keyboard switch it must not
  -- take focus back until the pointer enters another window.
  if settled or not dwellDue then
    return
  end
  settled = true
  win:focus()
end

local function onDwell()
  dwellDue = true
  evaluate()
end

function focus.start(options)
  if options and options.paused then
    paused = options.paused
  end
  systemElement = hs.axuielement.systemWideElement()
  -- Process-wide: it is the only bound on elementAtPosition, and it also
  -- applies to window moves in windows.lua.
  systemElement:setTimeout(AX_TIMEOUT_SECONDS)
  sampleTimer = hs.timer.delayed.new(SAMPLE_SECONDS, evaluate)
  dwellTimer = hs.timer.delayed.new(DWELL_SECONDS, onDwell)
  eventTap = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function(event)
    latestPoint = event:location()
    armSample()
    return false
  end)
  eventTap:start()
end

return focus
