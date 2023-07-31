return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
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
	{
		"tpope/vim-rhubarb",
		event = "VeryLazy",
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
			vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
			vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
			vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

			vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = "" -- custom config file path

			vim.cmd.cnoreabbrev("lg LazyGit")

			require("telescope").load_extension("lazygit")
		end,
	},
}
