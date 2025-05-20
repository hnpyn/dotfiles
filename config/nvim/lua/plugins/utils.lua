return {
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup({})
		end,
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
		"kelly-lin/ranger.nvim",
		config = function()
			require("ranger-nvim").setup({
				enable_cmds = true,
				replace_netrw = true,
			})
			vim.keymap.set("n", "<leader>ra", "", {
				desc = "Open ranger",
				noremap = true,
				silent = true,
				callback = function()
					require("ranger-nvim").open(true)
				end,
			})
			vim.cmd.cnoreabbrev("ra Ranger")
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
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
