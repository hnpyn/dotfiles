local set = vim.o
local util = require("util")

-- basic
set.autoindent = true
set.autoread = true
set.cursorline = true
set.expandtab = true
set.hidden = true
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.tabstop = 2
set.termguicolors = true -- pretty dress

-- clipboard
if util.is_remote() and not util.is_tmux() then
	set.clipboard = "unnamedplus"
	vim.g.clipboard = "osc52"
else
	set.clipboard = "unnamedplus"
end

-- highlight groups
-- vim.cmd("hi Visual guifg=#0d0e0f guibg=#e7d7ad gui=none")
vim.cmd("hi Search guifg=#0d0e0f guibg=#d79921 gui=none")
vim.cmd("hi IncSearch guifg=#0d0e0f guibg=#eebd35 gui=none")
vim.cmd("hi CurSearch guifg=#0d0e0f guibg=#689d6a gui=none")
