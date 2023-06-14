-- mouse bindings
local wezterm = require("wezterm")

mousebindings = {}

function mousebindings.mouseBindBasic()
	local mouse_bindings = {
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = wezterm.action.StartWindowDrag,
		},
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "CTRL|SHIFT",
			action = wezterm.action.StartWindowDrag,
		},
	}
	return mouse_bindings
end

return mousebindings
