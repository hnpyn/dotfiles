-- keybindings
local wezterm = require("wezterm")
local act = wezterm.action

keybindings = {}

-- basic
keybindings.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

function keybindings.keyBindBasic()
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

return keybindings
