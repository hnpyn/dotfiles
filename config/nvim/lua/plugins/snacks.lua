return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- file performance
			bigfile = { enabled = true },
			quickfile = { enabled = true },

			-- startup dashboard
			dashboard = {
				enabled = true,
				preset = {
					-- stylua: ignore start
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = "<Cmd>FzfLua files<CR>" },
						{ icon = " ", key = "n", desc = "New File", action = "<Cmd>ene | startinsert<CR>" },
						{ icon = " ", key = "g", desc = "Find Text", action = "<Cmd>FzfLua live_grep<CR>" },
						{ icon = " ", key = "r", desc = "Recent Files", action = "<Cmd>FzfLua oldfiles<CR>" },
						{ icon = "󰙅 ", key = "e", desc = "File explorer", action = "<Cmd>Oil --float<CR>" },
						{ icon = " ", key = "c", desc = "Config", action = "<Cmd>e $MYVIMRC<CR>" },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = "<Cmd>Lazy<CR>", enabled = package.loaded.lazy ~= nil },
						{ icon = " ", key = "q", desc = "Quit", action = "<Cmd>qa<CR>" },
					},
					-- stylua: ignore end
					header = [[
███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗
████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║
██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║
██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝]],
				},
			},

			-- editor ui
			indent = { enabled = true },
			input = { enabled = true, icon = "> " },
			scope = { enabled = true },
			scroll = { enabled = true },

			-- git url
			gitbrowse = {
				config = function(opts, defaults)
					-- table.insert(opts.remote_patterns, { "^(http://%d+%.%d+%.%d+%.%d+)(/.*)$", "%1:28088%2" })
					opts.url_patterns["%d+%.%d+%.%d+%.%d+"] = {
						branch = "/-/tree/{branch}",
						file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
						permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
						commit = "/-/commit/{commit}",
					}
				end,
			},
		},
		-- stylua: ignore start
		keys = {
			-- buffer / file
			{ "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
			{ "<Leader>br", function() Snacks.rename.rename_file() end, desc = "Rename File" },
			{ "<Leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },

			-- git
			{ "<Leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
			{
				"<Leader>gl",
				function()
					Snacks.gitbrowse({
						open = function(url)
							url = url:gsub("^https://http://", "http://")
							vim.fn.setreg("+", url)
							vim.notify("Copied [origin](" .. url .. ")")
						end,
						notify = false,
					})
				end,
				desc = "GitBrowse: Copy URL",
				mode = { "n", "x" },
			},
		},
		-- stylua: ignore end
	},
}
