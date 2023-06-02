return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		keys = {
			{ "<Leader>tt", "<CMD>NvimTreeToggle<CR>", desc = "nvim-tree toggle" },
			{ "<Leader>tf", "<CMD>NvimTreeFindFile<CR>", desc = "nvim-tree find file" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
					relativenumber = true,
				},
				renderer = {
					group_empty = true,
					full_name = true,
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
