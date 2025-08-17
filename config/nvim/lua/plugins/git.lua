return {
	{
		"tpope/vim-fugitive",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Git", "G" },
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
						return get_cutome_type_url(url_data)
					end,
					["ads.shineauto.com.cn"] = function(url_data)
						url_data.port = "28088"
						return get_cutome_type_url(url_data)
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
