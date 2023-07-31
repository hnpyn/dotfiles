return {
	{
		"stevearc/dressing.nvim",
		opts = {
			input = { default_prompt = "➤ " },
			select = { backend = { "telescope", "builtin" } },
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = { user_default_options = { names = false } },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				show_current_context_start = true,
				show_end_of_line = true,
			})
		end,
	},
}
