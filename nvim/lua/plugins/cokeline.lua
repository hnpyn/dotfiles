return {
	{
		"willothy/nvim-cokeline",
		config = function()
			local get_hex = require("cokeline/utils").get_hex
			local yellow = vim.g.terminal_color_3

			require("cokeline").setup({
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
		end,
	},
}
