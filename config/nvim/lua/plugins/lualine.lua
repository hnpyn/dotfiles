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
}
