return {
	{
		"glepnir/dashboard-nvim",
		enabled = false,
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.indent_blankline_filetype_exclude = { "dashboard" }
			require("dashboard").setup({
				-- theme = "doom",
				config = {
					header = {
						"",
						"",
						"███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗",
						"████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║",
						"██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║",
						"██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║",
						"██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║",
						"╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
						"",
					},
					-- center will be effective in theme doom
					center = {
						{
							icon = " ",
							icon_hl = "Title",
							desc = "Find File           ",
							desc_hl = "String",
							key = "b",
							keymap = "SPC f f",
							key_hl = "Number",
							action = "lua print(2)",
						},
						{
							icon = " ",
							desc = "Find Dotfiles",
							key = "f",
							keymap = "SPC f d",
							action = "lua print(3)",
						},
					},
					footer = {
						"",
						"🏀  Have fun with neovim !",
						" -- MingEn -- ",
						"",
					},
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
  		  ███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗
  		  ████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
  		  ██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║
  		  ██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║
  		  ██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║
  		  ╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝
      ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("e", "󰙅 " .. " File explorer", ":Oil --float <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <CR>]]),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy <CR>"),
				dashboard.button("q", " " .. " Quit", ":qa <CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			-- dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
