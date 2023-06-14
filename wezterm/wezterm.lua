-- WezTerm config
local wezterm = require("wezterm")

local config = {}

-- font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 18

-- pretty dress
config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
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

-- behavior
config.enable_scroll_bar = false

-- keybindings
require("extra.navigator")
local keybind = require("extra.keybindings")
local mousebind = require("extra.mousebindings")

config.leader = keybind.leader
config.keys = keybind.keyBindBasic()
config.mouse_bindings = mousebind.mouseBindBasic()

return config
