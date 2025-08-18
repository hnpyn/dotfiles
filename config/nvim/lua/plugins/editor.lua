return {
	{ "nvim-lua/plenary.nvim" },
	{
		"numToStr/Navigator.nvim",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		cmd = { "Telescope" },
		keys = {
			{ "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Telescope: find files" },
			{ "<Leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Telescope: live grep" },
			{ "<Leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Telescope: buffers" },
			{ "<Leader>fr", "<Cmd>Telescope resume<CR>", desc = "Telescope: resume" },
			{ "<Leader>fo", "<Cmd>Telescope oldfiles<CR>", desc = "Telescope: old files" },
		},
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				mappings = {
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
			},
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
				desc = "render-markdown: RenderMarkdown toggle",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>fe", "<Cmd>Oil<CR>", desc = "File Explorer" },
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
				"<leader>tt",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						dir = require("util").get_root(),
					})
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>te",
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
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 1000,
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<Leader>g", group = "+git" },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
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
}
