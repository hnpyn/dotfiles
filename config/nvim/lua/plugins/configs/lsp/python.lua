-- python language configs
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- pyright
-- lspconfig.pyright.setup({
-- 	capabilities = capabilities,
-- })

-- python-lsp-server
lspconfig.pylsp.setup({
	capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {
            "E203", "E231", "E302", "E711", "E741",
            "W291", "W293", "W503",
          },
          maxLineLength = 120,
        }
      }
    }
  }
})
