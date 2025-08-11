return {
  {
    "mason-org/mason.nvim",
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
        "lua-language-server",
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
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      servers = {
        pylsp = {
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
        },
        lua_ls = {
          settings = {
            Lua = {
              single_file_support = true,
              diagnostics = {
                globals = { "vim", "hs" },
              },
              workspace = {
                checkThirdParty = true,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        clangd = {},
      },
      setup = {},
    },
    config = function(_, opts)
      require("plugins.lsp.keymaps")

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      for server, cfg in pairs(servers) do
        if cfg then
          cfg = cfg == true and {} or cfg
          cfg = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, cfg or {})
          if cfg.enabled ~= false then
            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
          end
        end
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
        },
        on_attach = function(client, bufnr)
          if client:supports_method("textDocument/formatting") then
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
