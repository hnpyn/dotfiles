-- WezTerm config
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

-- font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 18

-- pretty dress
config.color_scheme = "Catppuccin Mocha"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

-- behavior
config.enable_scroll_bar = false

-- keybindings
require("navigator")
-- basic
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
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

return config
