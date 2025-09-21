return {
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = { user_default_options = { names = false } },
	},
	{
		"petertriho/nvim-scrollbar",
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			handlers = { gitsigns = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("config.ui").icons
			local Util = require("util")

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					icons_enabled = true,
					always_divide_middle = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
					sections = {
						-- left
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = { "filename" },
						-- right
						lualine_x = { "encoding", "fileformat", "filetype" },
						lualine_z = { "location" },
					},
					inactive_sections = {
						lualine_a = { "filename" },
						lualine_b = {},
						lualine_c = {},
						lualine_x = { "location" },
						lualine_y = {},
						lualine_z = {},
					},
					tabline = {},
					extensions = { "neo-tree", "lazy" },
				},
			}
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = true,
		event = "VeryLazy",
		version = "*",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
			{ "<Leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<Leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = function()
			local get_hex = require("util").get_hex
			return {
				options = {
					left_mouse_command = function(bufnum)
						local lazy = require("bufferline.lazy")
						local ui = lazy.require("bufferline.ui")
						local windows = vim.fn.win_findbuf(bufnum)
						if windows[1] then
							vim.api.nvim_set_current_win(windows[1])
						end
						vim.schedule(function()
							vim.cmd(string.format("buffer %d", bufnum))
							ui.refresh()
						end)
					end,
          -- stylua: ignore
          close_command = function(n) require("mini.bufremove").delete(n, false) end,
          -- stylua: ignore
          right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,
					diagnostics_indicator = function(_, _, diag)
						local icons = require("config.ui").icons.diagnostics
						local ret = (diag.error and icons.Error .. diag.error .. " " or "")
							.. (diag.warning and icons.Warn .. diag.warning or "")
						return vim.trim(ret)
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "neo-tree",
							highlight = "Directory",
							text_align = "left",
						},
					},
					separator_style = { "", "" }, -- ▎
				},
				highlights = {
					fill = { bg = get_hex("Normal", "bg") },
					background = { bg = get_hex("Normal", "bg") },
					separator = { bg = get_hex("Normal", "bg") },
					indicator_selected = { fg = "#b16286" },
					numbers = { bg = get_hex("Normal", "bg") },
					buffer = { bg = get_hex("Normal", "bg") },
					close_button = { bg = get_hex("Normal", "bg") },
					modified = { bg = get_hex("Normal", "bg") },
					duplicate = { bg = get_hex("Normal", "bg") },
					pick = { bg = get_hex("Normal", "bg") },
					diagnostic = { bg = get_hex("Normal", "bg") },
					error = { bg = get_hex("Normal", "bg") },
					error_diagnostic = { bg = get_hex("Normal", "bg") },
					warning = { bg = get_hex("Normal", "bg") },
					warning_diagnostic = { bg = get_hex("Normal", "bg") },
					info = { bg = get_hex("Normal", "bg") },
					info_diagnostic = { bg = get_hex("Normal", "bg") },
					hint = { bg = get_hex("Normal", "bg") },
					hint_diagnostic = { bg = get_hex("Normal", "bg") },
				},
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│", -- ▏
			},
			scope = { show_start = false, show_end = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo_lines = {
				"███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗",
				"████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║",
				"██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║",
				"██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║",
				"██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║",
				"╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
			}
			local logo = table.concat(
				vim.tbl_map(function(line)
					return "" .. line
				end, logo_lines),
				"\n"
			)

			dashboard.section.header.val = vim.split(logo, "\n")
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
