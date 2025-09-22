-- highlight after copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})

-- terminal keymaps
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		_G.set_terminal_keymaps()
	end,
})
