return {
	{
		"nvim-tree/nvim-tree.lua",
		enabled = true,
		version = "*",
		keys = {
			{ "<Leader>tt", "<CMD>NvimTreeToggle<CR>", desc = "nvim-tree toggle" },
			{ "<Leader>tf", "<CMD>NvimTreeFindFile<CR>", desc = "nvim-tree find file" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local map = vim.keymap.set

			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				map("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				map("n", "?", api.tree.toggle_help, opts("Help"))
			end

			-- pass to setup along with your other options
			require("nvim-tree").setup({
				-- disables netrw completely
				disable_netrw = false,
				on_attach = my_on_attach,
				sort_by = "case_sensitive",
				view = {
					width = 30,
					relativenumber = true,
				},
				renderer = {
					group_empty = true,
					full_name = true,
					icons = {
						show = {
							folder_arrow = true,
						},
						glyphs = {
							folder = {
								arrow_closed = " ",
								arrow_open = " ",
							},
						},
					},
				},
				filters = {
					custom = {
						".git/", -- 不显示 .git 目录内容
					},
					exclude = {
						".gitignore", -- 显示 .gitignore
					},
					dotfiles = true,
				},
				git = {
					enable = true,
				},
			})
		end,
	},
}
