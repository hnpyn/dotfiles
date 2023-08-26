return {
	{ "nvim-lua/plenary.nvim" },
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
			require("which-key").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		cmd = "Trouble",
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({})

			local function opts(desc)
				return { desc = "" .. desc, noremap = true, silent = true }
			end

			-- lazygit
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "curved",
					width = 160,
					height = 40,
				},
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

			-- keymaps
			vim.keymap.set("n", "<C-t>", "<Cmd>ToggleTerm size=40 direction=float<CR>", opts(""))
			vim.keymap.set("t", "<C-t>", "<C-\\><C-n><Cmd>q<CR>", opts(""))
			vim.keymap.set("n", "<Leader>lg", "<Cmd>lua _lazygit_toggle()<CR>", opts("Toggleterm: lazygit"))
			vim.cmd.cnoreabbrev("lg lua _lazygit_toggle()")
		end,
	},
	{
		"chrishrb/gx.nvim",
		event = { "BufEnter" },
		config = true, -- default settings
	},
}
