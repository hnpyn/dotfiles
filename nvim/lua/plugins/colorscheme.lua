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
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme gruvbox-baby")
	-- 	end,
	-- },
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
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warm",
			})
			vim.cmd("colorscheme onedark")
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd("colorscheme tokyonight-moon")
	-- 	end,
	-- },
}
