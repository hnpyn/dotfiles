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
		},
	},
	{
		"refractalize/oil-git-status.nvim",
		enabled = true,
		lazy = true,
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
	{
		"ruifm/gitlinker.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local get_custom_type_url = function(url_data)
				local url = "http://" .. url_data.host
				if url_data.port then
					url = url .. ":" .. url_data.port .. "/"
				end
				url = url .. url_data.repo .. "/-/blob/" .. url_data.rev .. "/" .. url_data.file
				if url_data.lstart then
					url = url .. "#L" .. url_data.lstart
					if url_data.lend then
						url = url .. "-L" .. url_data.lend
					end
				end
				return url
			end

			return {
				callbacks = {
					["112.29.101.105"] = function(url_data)
						url_data.port = "28088"
						return get_custom_type_url(url_data)
					end,
					["ads.shineauto.com.cn"] = function(url_data)
						url_data.port = "28088"
						return get_custom_type_url(url_data)
					end,
				},
				mappings = "<Leader>gl",
			}
		end,
		keys = {
			{
				"<Leader>gr",
				function()
					require("gitlinker").get_repo_url()
				end,
				mode = "n",
				desc = "Gitlinker: Copy repo URL",
			},
			{
				"<Leader>gR",
				function()
					require("gitlinker").get_repo_url({
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "n",
				desc = "Gitlinker: Open repo URL in browser",
			},
			{
				"<Leader>gL",
				function()
					require("gitlinker").get_buf_range_url("n", {
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "n",
				desc = "Gitlinker: Open buffer line URL in browser",
			},
			{
				"<Leader>gL",
				function()
					require("gitlinker").get_buf_range_url("v", {
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "v",
				desc = "Gitlinker: Open visual range URL in browser",
			},
		},
	},
}
