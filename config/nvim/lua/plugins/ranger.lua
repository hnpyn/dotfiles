return {
	{
		"kelly-lin/ranger.nvim",
		config = function()
			require("ranger-nvim").setup({
				enable_cmds = true,
				replace_netrw = true,
			})
			vim.keymap.set("n", "<leader>ra", "", {
				desc = "Open ranger",
				noremap = true,
				silent = true,
				callback = function()
					require("ranger-nvim").open(true)
				end,
			})
			vim.cmd.cnoreabbrev("ra Ranger")
		end,
	},
}
