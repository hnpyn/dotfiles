-- stylua: ignore start
local global_keys = {
  -- see `:help vim.diagnostic.*`
  { "[d", vim.diagnostic.goto_prev, desc = "Diagnostic go to prev" },
  { "]d", vim.diagnostic.goto_next, desc = "Diagnostic go to next" },
  { "<Leader>e", function() vim.diagnostic.open_float({ border = "rounded" }) end, desc = "Diagnostic open float" },
  -- { "<Leader>ll", vim.diagnostic.setloclist, desc = "Diagnostic set locllist" },
  { "<Leader>ll", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostic locllist" },
  { "<Leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP: symbols" },
}

local lsp_keys = {
  -- see `:help vim.lsp.*`
  { "gd", function() Snacks.picker.lsp_definitions() end, desc = "go to definition" },
  { "gD", function() Snacks.picker.lsp_declarations() end, desc = "go to declaration" },
  { "gri", function() Snacks.picker.lsp_implementations() end, desc = "go to implementation" },
  { "grr", function() Snacks.picker.lsp_references() end, desc = "go to reference" },
  { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "go to type definition" },
  { "grn", vim.lsp.buf.rename, desc = "rename" },
  { "gra", vim.lsp.buf.code_action, desc = "code action", mode = { "n", "v" } },
  { "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "hover documentation" },
  { "gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, desc = "signature help" },
  { "<Leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" },
  { "<Leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" },
  { "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "list workspace folders" },
}
-- stylua: ignore end

for _, k in ipairs(global_keys) do
  vim.keymap.set(k.mode or "n", k[1], k[2], { desc = k.desc })
end

-- use LspAttach to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    for _, k in ipairs(lsp_keys) do
      vim.keymap.set(k.mode or "n", k[1], k[2], { desc = "LSP: " .. k.desc, buffer = ev.buf })
    end
  end,
})
