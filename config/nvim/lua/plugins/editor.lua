return {
	{ "nvim-lua/plenary.nvim" },
	{
		"numToStr/Navigator.nvim",
		lazy = true,
		opts = {},
		keys = {
			{ "<C-h>", "<Cmd>NavigatorLeft<CR>", desc = "Navigate Left" },
			{ "<C-j>", "<Cmd>NavigatorDown<CR>", desc = "Navigate Down" },
			{ "<C-k>", "<Cmd>NavigatorUp<CR>", desc = "Navigate Up" },
			{ "<C-l>", "<Cmd>NavigatorRight<CR>", desc = "Navigate Right" },
		},
	},
	{
		"ibhagwan/fzf-lua",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "FzfLua" },
		opts = function()
			local img_previewer ---@type string[]?
			for _, v in ipairs({
				{ cmd = "ueberzug", args = {} },
				{ cmd = "chafa", args = { "{file}", "--format=symbols" } },
				{ cmd = "viu", args = { "-b" } },
			}) do
				if vim.fn.executable(v.cmd) == 1 then
					img_previewer = vim.list_extend({ v.cmd }, v.args)
					break
				end
			end
			return {
				fzf_colors = true,
				files = {
					fd_opts = [[--color=never --hidden --no-ignore --type f --type l --exclude .git]],
					rg_opts = [[--color=never --hidden --no-ignore --files -g "!.git"]],
				},
				previewers = {
					builtin = {
						extensions = {
							["png"] = img_previewer,
							["jpg"] = img_previewer,
							["jpeg"] = img_previewer,
							["gif"] = img_previewer,
							["webp"] = img_previewer,
						},
						ueberzug_scaler = "fit_contain",
					},
				},
			}
		end,
		keys = {
			{ "<leader>/", "<Cmd>FzfLua live_grep<CR>", desc = "Live Grep" },
			{ "<leader>:", "<Cmd>FzfLua command_history<CR>", desc = "Command History" },
			-- find
			{ "<leader>fb", "<Cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>", desc = "Find Buffers" },
			{ "<leader>ff", "<Cmd>FzfLua files<CR>", desc = "Find Files" },
			{ "<leader>fg", "<Cmd>FzfLua git_files<CR>", desc = "Find Git Files" },
			{ "<leader>fr", "<Cmd>FzfLua oldfiles<CR>", desc = "Recent Files" },
			{ "<leader>fR", "<Cmd>FzfLua resume<CR>", desc = "Resume Find" },
			-- git
			{ "<leader>gc", "<Cmd>FzfLua git_commits<CR>", desc = "Git: Commits" },
			{ "<leader>gs", "<Cmd>FzfLua git_status<CR>", desc = "Git: Status" },
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = {
			"RenderMarkdown",
			"RenderMarkdown toggle",
		},
		opts = {},
		keys = {
			{
				"<Leader>md",
				"<Cmd>RenderMarkdown toggle<CR>",
				mode = "n",
				desc = "RenderMarkdown: RenderMarkdown toggle",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "<Leader>fe", "<Cmd>Oil<CR>", desc = "File Explorer" },
		},
		opts = {
			default_file_explorer = true,
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
			},
			view_options = {
				show_hidden = true,
			},
			-- for oil-git-status
			win_options = {
				signcolumn = "yes:2",
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = true,
		cmd = "Neotree",
		keys = {
			{
				"<Leader>tt",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						dir = require("util").get_root(),
					})
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<Leader>te",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		-- init = function()
		-- 	if vim.fn.argc() == 1 then
		-- 		local stat = vim.loop.fs_stat(vim.fn.argv(0))
		-- 		if stat and stat.type == "directory" then
		-- 			require("neo-tree")
		-- 		end
		-- 	end
		-- end,
		opts = function()
			local icons = require("config.ui").icons
			return {
				popup_border_style = "rounded",
				use_popups_for_input = true,
				close_if_last_window = true,
				sources = { "filesystem", "buffers", "git_status", "document_symbols" },
				open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
				filesystem = {
					bind_to_cwd = false,
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
				},
				hijack_netrw_behavior = "disabled",
				window = {
					mappings = {
						["<space>"] = "none",
					},
				},
				default_component_configs = {
					indent = {
						with_expanders = nil, -- true, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = icons.file.FoldClosed,
						expander_expanded = icons.file.FoldOpen,
						expander_highlight = "NeoTreeExpander",
					},
					icon = {
						folder_empty = icons.file.FolderEmpty,
						folder_empty_open = icons.file.FolderEmpty,
						default = icons.file.DefaultFile,
					},
					modified = { symbol = icons.file.FileModified },
					git_status = {
						symbols = {
							added = icons.git.added,
							deleted = icons.git.removed,
							modified = icons.git.modified,
							renamed = icons.git.renamed,
							untracked = icons.git.untracked,
							ignored = icons.git.ignored,
							unstaged = icons.git.unstaged,
							staged = icons.git.staged,
							conflict = icons.git.conflict,
						},
					},
				},
			}
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
	{
		"nvim-mini/mini.files",
		enabled = true,
		opts = {
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 50,
			},
			options = {
				-- Whether to use for editing directories
				use_as_default_explorer = false,
			},
		},
		keys = {
			{
				"<leader>fm",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (Directory of Current File)",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 1000,
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<Leader>b", group = "+Buffer" },
				{ "<Leader>f", group = "+Finder" },
				{ "<Leader>t", group = "+Tree" },
				{ "<Leader>g", group = "+Git" },
				{ "<Leader>gh", group = "+Gitsigns" },
				{ "<Leader>gt", group = "+Gitsigns" },
				{ "<Leader>gl", desc = "Gitlinker: Copy buffer line url" },
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoFzfLua", "TodoQuickFix" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<Leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<Leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<Leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},
	{
		"echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<Leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<Leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
	},
}
