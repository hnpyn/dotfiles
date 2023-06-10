-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local function opts(desc)
			return { desc = "LSP: " .. desc, buffer = ev.buf }
		end
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("go to declaration"))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("go to definition"))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("hover"))
		-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts(" "))
		-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts(" "))
		vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts("add workspace folder"))
		vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))
		vim.keymap.set("n", "<Leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts("list workspace folders"))
		vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts("type definition"))
		vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts("rename"))
		vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts("code action"))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("go to references"))
		vim.keymap.set("n", "<Leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts("format"))
	end,
})
