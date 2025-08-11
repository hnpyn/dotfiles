-- general settings
local set = vim.o

set.autoindent = true
set.autoread = true
set.clipboard = "unnamedplus"
set.cursorline = true
set.expandtab = true
set.hidden = true
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.tabstop = 2
set.termguicolors = true -- pretty dress

-- highlight after copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({
      timeout = 300,
    })
  end,
})

-- highlight groups
vim.cmd("hi Visual guifg=#0d0e0f guibg=#e7d7ad gui=none")
vim.cmd("hi Search guifg=#0d0e0f guibg=#d79921 gui=none")
vim.cmd("hi IncSearch guifg=#0d0e0f guibg=#eebd35 gui=none")
vim.cmd("hi CurSearch guifg=#0d0e0f guibg=#689d6a gui=none")
