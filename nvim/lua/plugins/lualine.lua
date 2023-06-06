return {
	{
		"nvim-lualine/lualine.nvim",
		theme = "base16-tender",
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox-material",
				},
			})
		end,
	},
}
