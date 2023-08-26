return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					-- theme = "gruvbox-material",
				},
			})
		end,
	},
	{
		"willothy/nvim-cokeline",
		config = function()
			local map = vim.keymap.set

			local get_hex = require("cokeline/utils").get_hex
			local mappings = require("cokeline/mappings")

			local comments_fg = get_hex("Comment", "fg")
			local errors_fg = get_hex("DiagnosticError", "fg")
			local warnings_fg = get_hex("DiagnosticWarn", "fg")

			local red = vim.g.terminal_color_1
			local green = "#8ec07c" -- vim.g.terminal_color_2
			local yellow = "#eebd35" -- vim.g.terminal_color_3
			local active_bg_color = "#BD93F9"
			local inactive_bg_color = get_hex("Normal", "bg")
			local focused_color = "#ffffff" -- get_hex("Normal", "fg")
			local unfocused_color = "#555555" -- get_hex("Comment", "fg")

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
					filetype = "NvimTree",
					components = {
						{
							text = "  NvimTree",
							fg = yellow,
							bg = get_hex("NvimTreeNormal", "bg"),
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
		"akinsho/bufferline.nvim",
		enabled = false,
		version = "*",
		-- event = "VeryLazy",
		lazy = false,
		keys = {
			{ "<Leader>]", "<Cmd>BufferLineCycleNext<CR>", desc = "next buffer" },
			{ "<Leader>[", "<Cmd>BufferLineCyclePrev<CR>", desc = "prev buffer" },
			{ "<Leader>C", "<Cmd>BufferLinePickClose<CR>", desc = "close buffer" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					-- 左侧让出 nvim-tree 的位置
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							text_align = "left",
						},
					},
					-- separator_style = "slant",
				},
			})
		end,
	},
}
