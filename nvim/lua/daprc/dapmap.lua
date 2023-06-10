-- dap ui keybindings
local map = vim.keymap.set
local function opts(desc)
	return { desc = "Dap: " .. desc, noremap = true, silent = true }
end

map("n", ",c", function()
	require("dap").continue()
end, opts("continue"))
map("n", ",b", function()
	require("dap").toggle_breakpoint()
end, opts("set breakpoint"))
map("n", ",n", function()
	require("dap").step_over()
end, opts("step over"))
map("n", ",i", function()
	require("dap").step_into()
end, opts("setp into"))
map("n", ",o", function()
	require("dap").step_out()
end, opts("step out"))
map("n", ",q", function()
	require("dap").disconnect()
end, opts("disconnect"))
