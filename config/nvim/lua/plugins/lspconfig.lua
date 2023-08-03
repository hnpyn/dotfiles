return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "Mason", "Neoconf" },
		event = { "BufReadPost", "BufNewFile" },
	},
}
