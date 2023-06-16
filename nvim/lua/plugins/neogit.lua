return {
	{
		"TimUntersberger/neogit",
		event = "VeryLazy",
		cmd = "Neogit",
		config = function()
			require("neogit").setup({
				-- ...
			})
			vim.cmd.cnoreabbrev("git Neogit")
		end,
	},
}
