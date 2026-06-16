return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		version = false,
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0,
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSUninstall" },
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ensure_installed = {
				"c",
				"cpp",
				"css",
				"html",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Leader><CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
