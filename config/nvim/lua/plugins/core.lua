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
		branch = "main",
		commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
			require("which-key").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},
	{
		"echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
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
