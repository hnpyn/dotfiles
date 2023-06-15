-- mouse bindings
local wezterm = require("wezterm")
local act = wezterm.action

mousebindings = {}

function mousebindings.basic()
	local mouse = {
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = act.StartWindowDrag,
		},
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "CTRL|SHIFT",
			action = act.StartWindowDrag,
		},
	}
	return mouse
end

return mousebindings
