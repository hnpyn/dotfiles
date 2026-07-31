local set = vim.o
local util = require("util")

-- basic
set.autoindent = true
set.autoread = true
set.cursorline = true
set.expandtab = true
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.termguicolors = true

-- clipboard
if util.is_remote() and not util.is_tmux() then
	set.clipboard = "unnamedplus"
	vim.g.clipboard = "osc52"
else
	set.clipboard = "unnamedplus"
end
