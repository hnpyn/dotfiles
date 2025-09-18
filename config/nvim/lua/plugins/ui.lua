return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
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
		"willothy/nvim-cokeline",
		enabled = false,
		opts = function()
			local map = vim.keymap.set

			local get_hex = require("cokeline/utils").get_hex
			local mappings = require("cokeline/mappings")

			local comments_fg = get_hex("Comment", "fg")
			local errors_fg = get_hex("DiagnosticError", "fg")
			local warnings_fg = get_hex("DiagnosticWarn", "fg")

			local red = "#fb4934" -- vim.g.terminal_color_1
			local green = "#8ec07c" -- vim.g.terminal_color_2
			local yellow = "#eebd35" -- vim.g.terminal_color_3
			local active_bg_color = "#BD93F9"
			local inactive_bg_color = get_hex("Normal", "bg")
			local focused_color = get_hex("Normal", "fg")
			local unfocused_color = "#665c54" -- get_hex("Comment", "fg")

			local components = {
				space = {
					text = " ",
					truncation = { priority = 1 },
				},

				separator = {
					text = function(buffer)
						return buffer.index ~= 1 and "" or ""
						-- if buffer.index ~= 1 then
						-- 	return ""
						-- end
						-- return ""
					end,
					fg = inactive_bg_color,
					bg = function(buffer)
						if buffer.is_focused then
							return active_bg_color
						end
						return inactive_bg_color
					end,
					truncation = { priority = 1 },
				},

				tail = {
					text = "",
					fg = function(buffer)
						if buffer.is_focused then
							return active_bg_color
						end
						return inactive_bg_color
					end,
					bg = inactive_bg_color,
					truncation = { priority = 1 },
				},

				devicon = {
					text = function(buffer)
						return (mappings.is_picking_focus() or mappings.is_picking_close())
								and buffer.pick_letter .. " "
							or buffer.devicon.icon
					end,
					fg = function(buffer)
						return (mappings.is_picking_focus() and yellow)
							or (mappings.is_picking_close() and red)
							or buffer.devicon.color
					end,
					style = function(_)
						return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
					end,
					truncation = { priority = 1 },
				},

				index = {
					text = function(buffer)
						return buffer.index .. ": "
					end,
					truncation = { priority = 1 },
				},

				unique_prefix = {
					text = function(buffer)
						return buffer.unique_prefix
					end,
					fg = comments_fg,
					style = "italic",
					truncation = {
						priority = 3,
						direction = "left",
					},
				},

				filename = {
					text = function(buffer)
						return buffer.filename
					end,
					style = function(buffer)
						return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
							or (buffer.is_focused and "bold")
							or (buffer.diagnostics.errors ~= 0 and "underline")
							or nil
					end,
					truncation = {
						priority = 2,
						direction = "left",
					},
				},

				diagnostics = {
					text = function(buffer)
						return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
							or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
							or ""
					end,
					fg = function(buffer)
						return (buffer.diagnostics.errors ~= 0 and errors_fg)
							or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
							or nil
					end,
					truncation = { priority = 1 },
				},

				close_or_unsaved = {
					text = function(buffer)
						return buffer.is_modified and "●" or "󰅖"
					end,
					fg = function(buffer)
						return buffer.is_modified and green or nil
					end,
					delete_buffer_on_left_click = true,
					truncation = { priority = 1 },
				},
			}

			require("cokeline").setup({
				default_hl = {
					fg = function(buffer)
						return buffer.is_focused and focused_color or unfocused_color
					end,
					bg = "NONE",
					-- bg = function(buffer)
					-- 	if buffer.is_focused then
					-- 		return active_bg_color
					-- 	end
					-- end,
				},

				components = {
					components.separator,
					components.space,
					components.devicon,
					components.filename,
					components.space,
					components.close_or_unsaved,
					components.space,
					-- components.tail,
					components.separator,
				},

				sidebar = {
					filetype = { "neo-tree", "NvimTree" },
					components = {
						{
							text = function(buf)
								return vim.bo[buf.number].filetype
							end,
							fg = yellow,
							bg = get_hex("Normal", "bg"),
							style = "bold",
						},
					},
				},
			})

			-- cokeline keymap
			map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
			map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
			map("n", "<Leader>[", "<Plug>(cokeline-switch-prev)", { silent = true })
			map("n", "<Leader>]", "<Plug>(cokeline-switch-next)", { silent = true })
			map("n", "<Leader>C", "<Plug>(cokeline-pick-close)", { silent = true })

			for i = 1, 9 do
				map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
				map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│", -- ▏
			},
			scope = { enabled = false },
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
		main = "ibl",
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
