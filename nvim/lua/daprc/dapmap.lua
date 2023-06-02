-- dap ui keybindings
local map = vim.keymap.set
local opt = { noremap = true, silent = true }

map("n", ",c", function()
	require("dap").continue()
end, { desc = "dap continue" })
map("n", ",b", function()
	require("dap").toggle_breakpoint()
end, { desc = "dap set breakpoint" })
map("n", ",n", function()
	require("dap").step_over()
end, { desc = "dap step over" })
map("n", ",i", function()
	require("dap").step_into()
end, { desc = "dap setp into" })
map("n", ",o", function()
	require("dap").step_out()
end, { desc = "dap step out" })
map("n", ",q", function()
	require("dap").disconnect()
end, { desc = "dap disconnect" })
