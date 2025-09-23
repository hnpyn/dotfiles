-- Global mappings.
local map = vim.keymap.set

map("n", "<Leader>ft", "<Cmd>Lspsaga term_toggle<CR>", { desc = "Toggle terminal" })
map("n", "<Leader>lg", "<Cmd>Lspsaga term_toggle lazygit<CR>", { desc = "LazyGit" })

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic go to prev" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic go to next" })
-- map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Diagnostic open float" })
-- map("n", "<Leader>l", vim.diagnostic.setloclist, { desc = "Diagnostic set locllist" })

-- use lspsaga for diagnostic
map("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Diagnostic go to prev" })
map("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Diagnostic go to prev" })
map("n", "<Leader>e", "<Cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Diagnostic open float" })
map("n", "<Leader>ll", "<Cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Diagnostic set locllist" })

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
		-- map("n", "gi", vim.lsp.buf.implementation, opts(" "))
		-- map("n", "gr", vim.lsp.buf.references, opts("go to references"))
		-- use fzf-lua for references and implementation
		map("n", "gi", "<Cmd>FzfLua lsp_implementations<CR>", opts("go to implementations"))
		map("n", "gr", "<Cmd>FzfLua lsp_references<CR>", opts("go to references"))
		map("n", "<Leader>D", vim.lsp.buf.type_definition, opts("type definition"))

		map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts("hover documentation"))
		map("n", "<Leader>K", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, opts("signature help"))

		map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts("add workspace folder"))
		map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))
		map("n", "<Leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts("list workspace folders"))

		-- map("n", "<Leader>rn", vim.lsp.buf.rename, opts("rename"))
		-- map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts("code action"))
		-- use lspsaga for outline, rename and code action
		map("n", "<Leader>o", "<Cmd>Lspsaga outline<CR>", opts("outline"))
		map("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", opts("rename"))
		map({ "n", "v" }, "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts("code action"))
		map("n", "<Leader>cF", function()
			vim.lsp.buf.format({ async = true })
		end, opts("format"))
	end,
})
