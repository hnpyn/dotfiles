-- keybindings
local wezterm = require("wezterm")
local act = wezterm.action

keybindings = {}

-- basic
keybindings.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

function keybindings.basic()
	local keys = {
		-- manage window
		{
			key = "n",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnCommandInNewWindow({ cwd = "~" }),
		},
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnCommandInNewTab({ cwd = "~" }),
		},
		{
			key = "f",
			mods = "CTRL|SUPER",
			action = "ToggleFullScreen",
		},
		{
			key = "z",
			mods = "CTRL|SUPER",
			action = "TogglePaneZoomState",
		},
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
		{
			key = "H",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "J",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "K",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "L",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Right", 5 }),
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

return keybindings
