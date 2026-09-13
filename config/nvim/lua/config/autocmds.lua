-- highlight after copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.hl.on_yank({
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

-- highlight overrides
-- colorschemes run `hi clear` on load, so overrides must be reapplied
-- on ColorScheme instead of relying on load order
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local set_hl = vim.api.nvim_set_hl
		-- set_hl(0, "Visual", { fg = "#0d0e0f", bg = "#e7d7ad", bold = false })
		set_hl(0, "Search", { fg = "#0d0e0f", bg = "#d79921", bold = false })
		set_hl(0, "IncSearch", { fg = "#0d0e0f", bg = "#eebd35", bold = false })
		set_hl(0, "CurSearch", { fg = "#0d0e0f", bg = "#689d6a", bold = false })
		-- set_hl(0, "WinSeparator", { fg = "bg", bg = "NONE", bold = false })
	end,
})
