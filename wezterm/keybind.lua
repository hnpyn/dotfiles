-- mac keybindings
local wezterm = require("wezterm")
local act = wezterm.action

keybind = {}

-- basic
keybind.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

function keybind.keyBindBasic()
	local keys = {
		-- manage pane
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		-- navigator
		{
			key = "h",
			mods = "CTRL",
			action = act.EmitEvent("ActivatePaneDirection-left"),
		},
		{
			key = "j",
			mods = "CTRL",
			action = act.EmitEvent("ActivatePaneDirection-down"),
		},
		{
			key = "k",
			mods = "CTRL",
			action = act.EmitEvent("ActivatePaneDirection-up"),
		},
		{
			key = "l",
			mods = "CTRL",
			action = act.EmitEvent("ActivatePaneDirection-right"),
		},
	}
	return keys
end

return keybind
