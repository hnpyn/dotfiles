return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { fast_wrap = {} },
	},
	{
		"kylechui/nvim-surround",
		keys = { "ys", "cs", "ds" },
		opts = {},
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{
		"saghen/blink.cmp",
		enabled = true,
		event = "InsertEnter",
		dependencies = {
			{
				"fang2hou/blink-copilot",
				opts = {
					kind_icon = "",
				},
			},
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				list = {
					selection = {
						preselect = false,
					},
				},
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = { enabled = false },
			},
			cmdline = {
				keymap = {
					preset = "inherit",
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = {
					list = {
						selection = {
							preselect = false,
						},
					},
					menu = { auto_show = true },
				},
			},
			sources = {
				default = { "copilot", "lsp", "path", "snippets", "buffer" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
