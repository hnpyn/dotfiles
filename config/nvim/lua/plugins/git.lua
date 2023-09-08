return {
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
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "GitSigns Next Hunk")
        map("n", "[h", gs.prev_hunk, "GitSigns Prev Hunk")
        map({ "n", "v" }, "<Leader>ghs", "<Cmd>Gitsigns stage_hunk<CR>", "GitSigns Stage Hunk")
        map({ "n", "v" }, "<Leader>ghr", "<Cmd>Gitsigns reset_hunk<CR>", "GitSigns Reset Hunk")
        map("n", "<Leader>ghS", gs.stage_buffer, "GitSigns Stage Buffer")
        map("n", "<Leader>ghu", gs.undo_stage_hunk, "GitSigns Undo Stage Hunk")
        map("n", "<Leader>ghR", gs.reset_buffer, "GitSigns Reset Buffer")
        map("n", "<Leader>ghp", gs.preview_hunk, "GitSigns Preview Hunk")
        map("n", "<Leader>ghb", function() gs.blame_line({ full = true }) end, "GitSigns Blame Line")
        map("n", "<Leader>ghd", gs.diffthis, "GitSigns Diff This")
        map("n", "<Leader>ghD", function() gs.diffthis("~") end, "GitSigns Diff This ~")
        map({ "o", "x" }, "ih", "<Cmd><C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.cmd.cnoreabbrev("diff DiffviewOpen")
		end,
		opts = function()
			local actions = require("diffview.actions")
			return {
				signs = {
					fold_closed = "",
					fold_open = "",
				},
				hooks = {
					-- See ':h diffview-config-hooks'
					view_opened = function()
						actions.toggle_files()
					end,
				},
				keymaps = {
					view = {
						["<tab>"] = false,
						["q"] = function()
							return actions.close()
						end,
						-- { "n", "<Leader>b", actions.toggle_files, { desc = "Toggle the diff file panel." } },
					},
				},
			}
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local map = vim.keymap.set

			map("n", "<Leader>gr", '<Cmd>lua require"gitlinker".get_repo_url()<CR>', { silent = true })
			map(
				"n",
				"<Leader>gR",
				'<Cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<CR>',
				{ silent = true }
			)
			map(
				"n",
				"<Leader>gL",
				'<Cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
				{ silent = true }
			)
			map(
				"v",
				"<Leader>gL",
				'<Cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
				{}
			)

			require("gitlinker").setup({
				callbacks = {
					["gitlab.utopilot.com.cn"] = require("gitlinker.hosts").get_gitlab_type_url,
				},
				mappings = "<Leader>gl",
			})
		end,
	},
}
