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
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.99

-- behavior
config.enable_scroll_bar = false

-- keybindings
require("extra.navigator")
local keybind = require("extra.keybindings")

config.leader = keybind.leader
config.keys = keybind.keyBindBasic()

return config
