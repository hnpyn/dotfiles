return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ensure_installed = {
				"c",
				"cpp",
				"vim",
				"html",
				"css",
				"lua",
				"javascript",
				"typescript",
				"tsx",
				"python",
				"markdown",
				"markdown_inline",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		enabled = true,
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
