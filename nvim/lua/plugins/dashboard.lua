return {
	{
		"glepnir/dashboard-nvim",
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
}
