return {
	{
		"tpope/vim-fugitive",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Git", "G" },
		keys = {
			{
				"<Leader>gg",
				"<Cmd>Git<CR>",
				desc = "Git: fugitive",
			},
			{
				"<Leader>gv",
				"<Cmd>vert Git<CR>",
				desc = "Git: fugitive vertical",
			},
			{
				"gh",
				"<Cmd>diffget //2<CR>",
				desc = "Git: fugitive accept ours",
			},
			{
				"gl",
				"<Cmd>diffget //3<CR>",
				desc = "Git: fugitive accept theirs",
			},
		},
	},
	{
		"refractalize/oil-git-status.nvim",
		enabled = true,
		dependencies = "stevearc/oil.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        -- navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        -- actions
        map("n", "<Leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<Leader>ghd", gs.diffthis, "Diff This")
        map("n", "<Leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map("n", "<Leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<Leader>ghq", gs.setqflist, "Quickfix List")
        map("n", "<Leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("n", "<Leader>ghs", gs.stage_hunk, "Stage Hunk")
        map("v", "<Leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
        map("v", "<Leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
        map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        -- toggles
        map('n', '<leader>gtd', gs.toggle_deleted, "Toggle Deleted")
        map('n', '<leader>gtb', gs.toggle_current_line_blame, "Toggle Current Line Blame")
        map('n', '<leader>gtw', gs.toggle_word_diff, "Toggle Word Diff")
        -- text object
        map({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", "Select Hunk")
				-- stylua: ignore end
			end,
		},
	},
}
