return {
	{
    "tpope/vim-fugitive",
    event = "VeryLazy",
    cmd = "Git",
    config = function()
			-- convert
			vim.cmd.cnoreabbrev([[git Git]])
			vim.cmd.cnoreabbrev([[P Git push]])
		end,
  }
}
