return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		cmd = {
			"Telescope",
		},
		keys = {
			{ "<Leader>ff", "<CMD>Telescope find_files<CR>", desc = "Telescope: find files" },
			{ "<Leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Telescope: live grep" },
			{ "<Leader>fb", "<CMD>Telescope buffers<CR>", desc = "Telescope: buffers" },
			{ "<Leader>fr", "<CMD>Telescope resume<CR>", desc = "Telescope: resume" },
			{ "<Leader>fo", "<CMD>Telescope oldfiles<CR>", desc = "Telescope: old files" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
