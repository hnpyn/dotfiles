local set = vim.o
local util = require("util")
local set_hl = vim.api.nvim_set_hl

-- basic
set.autoindent = true
set.autoread = true
set.cursorline = true
set.expandtab = true
set.hidden = true
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

-- highlight
-- sel_hl(0, "Visual", { fg = "#0d0e0f", bg = "e7d7ad", bold = false })
set_hl(0, "Search", { fg = "#0d0e0f", bg = "#d79921", bold = false })
set_hl(0, "IncSearch", { fg = "#0d0e0f", bg = "#eebd35", bold = false })
set_hl(0, "CurSearch", { fg = "#0d0e0f", bg = "#689d6a", bold = false })
-- set_hl(0, "WinSeparator", { fg = "bg", bg = "NONE", bold = false })
