-- WezTerm config
local wezterm = require("wezterm")

local config = {}

-- font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 18

-- pretty dress
config.color_scheme = "GruvboxDark" -- "tokyonight_night"
config.colors = {
	split = "#107dac",
}

-- tab bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- window
config.initial_cols = 70
config.initial_rows = 21
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.99
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.native_macos_fullscreen_mode = true
config.enable_scroll_bar = false
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- mouse
config.hide_mouse_cursor_when_typing = true

-- keybindings
require("extra.navigator")
local keybindings = require("extra.keybindings")
local mousebindings = require("extra.mousebindings")

config.leader = keybindings.leader
config.keys = keybindings.basic()
config.mouse_bindings = mousebindings.basic()

return config
