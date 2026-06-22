return {
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"petertriho/nvim-scrollbar",
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			handlers = { gitsigns = true },
		},
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
			{ "[B", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
			{ "]B", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next" },
			{ "<Leader>bD", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
			{ "<Leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<Leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = function()
			local get_hex = require("util").get_hex
			return {
				options = {
          -- stylua: ignore start
          close_command = function(n) Snacks.bufdelete(n) end,
          right_mouse_command = function(n) Snacks.bufdelete(n) end,
					-- stylua: ignore end
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
							text = "Neo-tree",
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
		config = function(_, opts)
			local bufferline = require("bufferline")
			bufferline.setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(bufferline.refresh)
					end)
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- PERF: we don't need this lualine require madness
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = require("config.ui").icons

			vim.o.laststatus = vim.g.lualine_laststatus

			return {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "alpha", "dashboard", "snacks_dashboard" } },
				},
				sections = {
					-- left
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						"diff",
					},
					lualine_c = {
						"filename",
						{
							"diagnostics",
							symbols = {
								error = "E", -- icons.diagnostics.Error,
								warn = "W", -- icons.diagnostics.Warn,
								info = "I", -- icons.diagnostics.Info,
								hint = "H", -- icons.diagnostics.Hint,
							},
						},
					},
					-- right
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = { "neo-tree", "lazy", "fzf" },
			}
		end,
	},
}
