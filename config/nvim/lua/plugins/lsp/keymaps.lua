-- global mappings
local map = vim.keymap.set

-- see `:help vim.diagnostic.*`
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic go to prev" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic go to next" })
map("n", "<Leader>e", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Diagnostic open float" })
-- map("n", "<Leader>ll", vim.diagnostic.setloclist, { desc = "Diagnostic set locllist" })

-- use FzfLua
map("n", "<Leader>ll", "<Cmd>FzfLua diagnostics_document<CR>", { desc = "Diagnostic locllist" })
map("n", "<Leader>ls", "<Cmd>FzfLua lsp_document_symbols<CR>", { desc = "LSP: symbols" })

-- use LspAttach to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- buffer local mappings
    -- see `:help vim.lsp.*`
    local function opts(desc)
      return { desc = "LSP: " .. desc, buffer = ev.buf }
    end

    -- use FzfLua lsp_* instead
    map("n", "gd", "<Cmd>FzfLua lsp_definitions<CR>", opts("go to definition"))
    map("n", "gD", "<Cmd>FzfLua lsp_declarations<CR>", opts("go to declaration"))
    map("n", "gri", "<Cmd>FzfLua lsp_implementations<CR>", opts("go to implementation"))
    map("n", "grr", "<Cmd>FzfLua lsp_references<CR>", opts("go to reference"))
    map("n", "grt", "<Cmd>FzfLua lsp_typedefs<CR>", opts("go to type definition"))
    map("n", "grn", vim.lsp.buf.rename, opts("rename"))
    map({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts("code action"))

    map("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, opts("hover documentation"))
    map("n", "gK", function()
      vim.lsp.buf.signature_help({ border = "rounded" })
    end, opts("signature help"))

    map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts("add workspace folder"))
    map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))
    map("n", "<Leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("list workspace folders"))
  end,
})
