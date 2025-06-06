return {
	{
		"numToStr/Navigator.nvim",
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		enabled = true,
		lazy = true,
		ft = "markdown",
		cmd = {
			"MarkdownPreview",
			"MarkdownPreviewStop",
		},
		keys = {
			{ "<Leader>md", "<Cmd>MarkdownPreview<CR>", desc = "open markdown preview" },
			{ "<Leader>ms", "<Cmd>MarkdownPreviewStop<CR>", desc = "stop markdown preview" },
			{ "<Leader>mt", "<Cmd>MarkdownPreviewToggle<CR>", desc = "open markdown toggle" },
		},
		-- build = function()
		-- 	vim.fn["mkdp#util#install"]()
		-- end,
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_auto_close = true
			vim.g.mkdp_open_to_the_world = false
			vim.g.mkdp_open_ip = "127.0.0.1"
			vim.g.mkdp_port = "8888"
			vim.g.mkdp_browser = ""
			vim.g.mkdp_echo_preview_url = true
			vim.g.mkdp_page_title = "${name}"
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
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
}
