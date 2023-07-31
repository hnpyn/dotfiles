return {
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	-- Optional dependencies
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("aerial").setup({
	-- 			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	-- 			on_attach = function(bufnr)
	-- 				-- Jump forwards/backwards with '{' and '}'
	-- 				vim.keymap.set("n", "{", "<Cmd>AerialPrev<CR>", { buffer = bufnr })
	-- 				vim.keymap.set("n", "}", "<Cmd>AerialNext<CR>", { buffer = bufnr })
	-- 			end,
	-- 		})
	-- 		-- You probably also want to set a keymap to toggle aerial
	-- 		vim.keymap.set("n", "<Leader>a", "<Cmd>AerialToggle!<CR>")
	-- 	end,
	-- },
	{
		"stevearc/aerial.nvim",
		opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			disable_max_lines = 1000,
			disable_max_size = 102400,
			layout = { min_width = 28 },
			show_guides = true,
			filter_kind = false,
			guides = {
				mid_item = "├ ",
				last_item = "└ ",
				nested_top = "│ ",
				whitespace = "  ",
			},
			keymaps = {
				["[y"] = "actions.prev",
				["]y"] = "actions.next",
				["[Y"] = "actions.prev_up",
				["]Y"] = "actions.next_up",
				["{"] = false,
				["}"] = false,
				["[["] = false,
				["]]"] = false,
			},
		},
		config = function()
			require("aerial").setup({})
			vim.keymap.set("n", "<Leader>a", "<Cmd>AerialToggle!<CR>")
		end,
	},
}
