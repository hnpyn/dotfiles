-- keybindings
-- default settings
local map = vim.keymap.set

local function opts(desc)
	return { desc = "" .. desc, noremap = true, silent = true }
end

-- basic
vim.g.mapleader = " "
map("i", "jj", "<Esc>", opts(""))
map("n", "<Esc>", "<CMD>noh<CR>", opts(""))
map("n", "<C-c><C-c>", "<CMD>qa!<CR>", opts(""))
map("n", ",w", "<CMD>w<CR>", opts("Write"))

-- cursor behaviors
map("i", "<C-e>", "<C-o>A", opts("Insert at the end of line"))
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
map("n", "j", [[v:count ? 'j': 'gj']], { noremap = true, expr = true })
map("n", "k", [[v:count ? 'k': 'gk']], { noremap = true, expr = true })

-- window behaviors
map({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
map({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
map({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
map({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
map("n", "<Leader>s", "<C-w>s", opts("Split window"))
map("n", "<Leader>v", "<C-w>v", opts("Split window vertical"))
map("n", "<Leader>x", "<C-w>q", opts("Kill a pane"))

-- terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts("Normal mode"))
