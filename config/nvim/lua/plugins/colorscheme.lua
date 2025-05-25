return {
	-- {
	-- 	"RRethy/nvim-base16",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- setup must be called before loading the colorscheme
	-- 		-- Default options:
	-- 		-- vim.cmd("colorscheme nvim-base16-gruvbox-soft")
	-- 	end,
	-- },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("gruvbox").setup({
	-- 			-- ...
	-- 		})
	-- 		vim.o.background = "dark"
	-- 		-- vim.cmd("colorscheme gruvbox")
	-- 	end,
	-- },
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.o.background = "dark"
	-- 		vim.cmd("let g:gruvbox_material_background = 'soft'")
	-- 		vim.cmd("colorscheme gruvbox-material")
	-- 	end,
	-- },
	-- {
	-- 	"luisiacc/gruvbox-baby",
	-- 	enabled = true,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme gruvbox-baby")
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme catppuccin-frappe")
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("github-theme").setup({
	-- 			-- ...
	-- 		})
	-- 		vim.cmd("colorscheme github_dark")
	-- 	end,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			-- ...
	-- 		})
	-- 		-- vim.cmd("colorscheme kanagawa")
	-- 	end,
	-- },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			style = "darker",
	-- 		})
	-- 		vim.cmd("colorscheme onedark")
	-- 	end,
	-- },
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme dracula")
	-- 	end,
	-- },
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme nord")
	-- 	end,
	-- },
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.o.background = "dark"

	-- 		local c = require("vscode.colors").get_colors()
	-- 		require("vscode").setup({
	-- 			-- Alternatively set style in setup
	-- 			-- style = 'light'

	-- 			-- Enable transparent background
	-- 			transparent = false,

	-- 			-- Enable italic comment
	-- 			italic_comments = true,

	-- 			-- Disable nvim-tree background color
	-- 			disable_nvimtree_bg = true,

	-- 			-- Override colors (see ./lua/vscode/colors.lua)
	-- 			color_overrides = {
	-- 				vscLineNumber = "#FFFFFF",
	-- 			},

	-- 			-- Override highlight groups (see ./lua/vscode/theme.lua)
	-- 			group_overrides = {
	-- 				-- this supports the same val table as vim.api.nvim_set_hl
	-- 				-- use colors from this colorscheme by requiring vscode.colors!
	-- 				Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
	-- 			},
	-- 		})
	-- 		require("vscode").load()
	-- 	end,
	-- },
}
