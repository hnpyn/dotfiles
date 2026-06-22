return {
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│", -- ▏
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"lazyterm",
					"mason",
					"neo-tree",
					"notify",
					"oil",
					"oil_preview",
					"terminal",
					"toggleterm",
					"Trouble",
				},
			},
		},
	},
	{
		"nvim-mini/mini.indentscope",
		enabled = false,
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			draw = {
				delay = 0,
				animation = function(s, n)
					return 2
				end,
			},
			options = { try_as_border = true },
			symbol = "╎", -- | │ ▏
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"alpha",
					"dashboard",
					"erlang",
					"fzf",
					"help",
					"lazy",
					"lazyterm",
					"markdown",
					"mason",
					"neo-tree",
					"notify",
					"oil",
					"oil_preview",
					"terminal",
					"toggleterm",
					"trouble",
					"Trouble",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		enabled = false,
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = {
				"███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗",
				"████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║",
				"██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║",
				"██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║",
				"██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║",
				"╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
			}

			dashboard.section.header.val = logo
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", "<Cmd>FzfLua files<CR>"),
				dashboard.button("n", " " .. " New file", "<Cmd>ene <BAR> startinsert<CR>"),
				dashboard.button("r", " " .. " Recent files", "<Cmd>FzfLua oldfiles<CR>"),
				dashboard.button("g", " " .. " Find text", "<Cmd>FzfLua live_grep<CR>"),
				dashboard.button("e", "󰙅 " .. " File explorer", "<Cmd>Oil --float<CR>"),
				dashboard.button("s", " " .. " Restore Session", [[<Cmd>lua require("persistence").load()<CR>]]),
				dashboard.button("c", " " .. " Config", "<Cmd>e $MYVIMRC<CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", "<Cmd>Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", "<Cmd>qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
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
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					vim.opt.laststatus = 0
				end,
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		enabled = false,
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = {
			user_default_options = {
				RRGGBBAA = true,
				names = false,
			},
		},
	},
}
