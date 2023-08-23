-- local configs
local set = vim.o

-- editor behavior
set.number = true
set.relativenumber = true
set.hidden = true
-- set.scrolloff = 2
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.autoindent = true
set.cursorline = true
set.nobackup = true
set.nowritebackup = true
set.autoread = true
set.clipboard = "unnamedplus"
-- highlight after copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})

-- pretty dress
set.termguicolors = true

-- highlights
vim.cmd("hi Visual guifg=#0d0e0f guibg=#e7d7ad gui=none")
vim.cmd("hi Search guifg=#0d0e0f guibg=#eebd35 gui=none")
vim.cmd("hi IncSearch guifg=#0d0e0f guibg=#eebd35 gui=none")
vim.cmd("hi CurSearch guifg=#0d0e0f guibg=#ffffff gui=none")

-- bridge mason and lspconfig
require("mason").setup()
require("mason-lspconfig").setup()

-- bootstrap dap ui
require("dapui").setup()
