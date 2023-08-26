-- Global mappings.
local map = vim.keymap.set
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Diagnostic open float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic go to prev" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic go to next" })
-- map("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set locllist" })

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
		map("n", "gD", vim.lsp.buf.declaration, opts("go to declaration"))
		map("n", "gd", vim.lsp.buf.definition, opts("go to definition"))
		map("n", "K", vim.lsp.buf.hover, opts("hover"))
		-- map("n", "gi", vim.lsp.buf.implementation, opts(" "))
		-- map("n", "<C-k>", vim.lsp.buf.signature_help, opts(" "))
		map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts("add workspace folder"))
		map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))
		map("n", "<Leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts("list workspace folders"))
		map("n", "<Leader>D", vim.lsp.buf.type_definition, opts("type definition"))
		map("n", "<Leader>rn", vim.lsp.buf.rename, opts("rename"))
		map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts("code action"))
		map("n", "gr", vim.lsp.buf.references, opts("go to references"))
		map("n", "<Leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts("format"))
	end,
})
