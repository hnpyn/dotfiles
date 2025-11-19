local map = vim.keymap.set

local function opts(desc)
	return { desc = "" .. desc, noremap = true, silent = true }
end

-- basic
map("i", "jj", "<Esc>", opts(""))
map("n", ",w", "<Cmd>w<CR>", opts("Write"))
map("n", "<Esc>", "<Cmd>noh<CR>", opts(""))
map("n", "<C-c><C-c>", "<Cmd>qa!<CR>", opts("Force Quit!"))
map("n", "<Leader>qq", "<Cmd>qa<CR>", opts("Quit All"))

-- cursor behaviors
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
map("n", "j", [[v:count ? 'j': 'gj']], { noremap = true, expr = true })
map("n", "k", [[v:count ? 'k': 'gk']], { noremap = true, expr = true })

-- window behaviors
map("n", "<Leader>s", "<C-w>s", opts("Split window"))
map("n", "<Leader>v", "<C-w>v", opts("Split window vertical"))
map("n", "<Leader>x", "<C-w>q", opts("Kill a pane"))
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- terminal
function _G.set_terminal_keymaps()
	local opt = { buffer = 0 }
	map("t", "<Esc><Esc>", "<C-\\><C-n>", opt)
	map("t", "<C-w>", "<C-\\><C-n><C-w>", opt)
	map("t", "<C-h>", "<Cmd>wincmd h<CR>", opt)
	map("t", "<C-j>", "<Cmd>wincmd j<CR>", opt)
	map("t", "<C-k>", "<Cmd>wincmd k<CR>", opt)
	map("t", "<C-l>", "<Cmd>wincmd l<CR>", opt)
end
