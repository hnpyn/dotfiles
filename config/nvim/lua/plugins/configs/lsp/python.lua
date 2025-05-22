-- python language configs

-- pyright
-- vim.lsp.enable("pyright")

-- python-lsp-server
vim.lsp.config("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {
						"E203",
						"E231",
						"E302",
						"E711",
						"E741",
						"W291",
						"W293",
						"W503",
					},
					maxLineLength = 120,
				},
			},
		},
	},
})
