-- keybindings
-- default settings
local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- basic
vim.g.mapleader = " "
map("i", "jj", "<Esc>", opt)
map("n", ",w", "<CMD>w<CR>", { desc = "write", silent = true })
map("n", "<C-c><C-c>", "<CMD>qa!<CR>", opt)
map("n", "<Esc>", "<CMD>noh<CR>", opt)

-- cursor behaviors
map("i", "<C-e>", "<C-o>A", { desc = "Insert at the end of line", silent = true })
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
map("n", "j", [[v:count ? 'j': 'gj']], { noremap = true, expr = true })
map("n", "k", [[v:count ? 'k': 'gk']], { noremap = true, expr = true })

-- window behaviors
map({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
map({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
map({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
map({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
map("n", "<Leader>v", "<C-w>v", { desc = "split window h vertical", silent = true })
map("n", "<Leader>s", "<C-w>s", { desc = "split window h horizontal", silent = true })
map("n", "<Leader>x", "<C-w>q", { desc = "quit a window", silent = true })

-- cokeline keymap
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })
map("n", "<Leader>C", "<Plug>(cokeline-pick-close)", { silent = true })

for i = 1, 9 do
	map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
	map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
end
