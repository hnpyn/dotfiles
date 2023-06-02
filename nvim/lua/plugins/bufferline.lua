return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		-- event = "VeryLazy",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<Leader>]", "<CMD>BufferLineCycleNext<CR>", desc = "next buffer" },
			{ "<Leader>[", "<CMD>BufferLineCyclePrev<CR>", desc = "prev buffer" },
			{ "<Leader>C", "<CMD>BufferLinePickClose<CR>", desc = "close buffer" },
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
				},
			})
		end,
	},
}
