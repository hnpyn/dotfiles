-- loaded only when embedded in Cursor / VS Code via vscode-neovim
-- init.lua returns right after this, so lazy and every terminal plugin stay out

local map = vim.keymap.set

local function opts(desc)
  return { desc = "" .. desc, noremap = true, silent = true }
end

-- the `vscode` module only exists when nvim is spawned by the extension,
-- so require it lazily to keep this file loadable on its own
---@param name string
local function action(name)
  return function()
    require("vscode").action(name)
  end
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- clipboard
vim.o.clipboard = "unnamedplus"
if vim.g.vscode_clipboard then
  vim.g.clipboard = vim.g.vscode_clipboard
end

-- basic
map("i", "jj", "<Esc>", opts(""))
map("n", ",w", "<Cmd>w<CR>", opts("Write"))
map("n", "<Esc>", "<Cmd>noh<CR>", opts(""))

-- window behaviors
-- native <C-w> only moves nvim's own windows, so delegate to VSCode
map("n", "<C-h>", action("workbench.action.navigateLeft"), opts("Go to Left Window"))
map("n", "<C-j>", action("workbench.action.navigateDown"), opts("Go to Lower Window"))
map("n", "<C-k>", action("workbench.action.navigateUp"), opts("Go to Upper Window"))
map("n", "<C-l>", action("workbench.action.navigateRight"), opts("Go to Right Window"))
map("n", "<Leader>s", action("workbench.action.splitEditorDown"), opts("Split window"))
map("n", "<Leader>v", action("workbench.action.splitEditor"), opts("Split window vertical"))
map("n", "<Leader>x", action("workbench.action.closeActiveEditor"), opts("Kill a pane"))

-- vscode panels
map("n", "<Leader>:", action("workbench.action.showCommands"), opts("Show Commands"))
map("n", "<Leader>ff", action("workbench.action.quickOpen"), opts("Find Files"))
map("n", "<Leader>/", action("workbench.action.findInFiles"), opts("Live Grep"))
map("n", "<Leader>ss", action("workbench.action.gotoSymbol"), opts("Goto Symbol"))
