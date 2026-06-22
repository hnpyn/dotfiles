return {
	{
		"folke/todo-comments.nvim",
		enabled = false,
		cmd = { "TodoFzfLua", "TodoQuickFix" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
		},
	},
	{
		"numToStr/Navigator.nvim",
		enabled = false,
		opts = {},
		keys = {
			{ "<C-h>", "<Cmd>NavigatorLeft<CR>", desc = "Navigate Left" },
			{ "<C-j>", "<Cmd>NavigatorDown<CR>", desc = "Navigate Down" },
			{ "<C-k>", "<Cmd>NavigatorUp<CR>", desc = "Navigate Up" },
			{ "<C-l>", "<Cmd>NavigatorRight<CR>", desc = "Navigate Right" },
		},
	},
}
