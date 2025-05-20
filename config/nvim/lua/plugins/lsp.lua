return {
  { "folke/neodev.nvim",                opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
      "MasonUpdateAll",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "black",
        "python-lsp-server",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "120" },
          }),
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.markdownlint,
          -- null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.shfmt,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
