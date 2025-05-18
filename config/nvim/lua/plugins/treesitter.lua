return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		config = function()
			-- change highlight
			-- vim.api.nvim_set_hl(0, "@lsp.type.variable.lua", { link = "Normal" })
			-- vim.api.nvim_set_hl(0, "Identifier", { link = "Normal" })
			-- vim.api.nvim_set_hl(0, "TSVariable", { link = "Normal" })
			require("nvim-treesitter.configs").setup({
				-- :TSInstallInfo 命令查看支持的语言
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
					"cuda",
					"markdown",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
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
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		enabled = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
