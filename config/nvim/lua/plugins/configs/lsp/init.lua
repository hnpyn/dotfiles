-- neodev
require("neodev").setup({})
-- bridge mason and lspconfig
require("mason").setup()
require("mason-lspconfig").setup()
-- key maps
require("plugins.configs.lsp.mappings")
-- lua language
require("plugins.configs.lsp.lua")
-- python language
require("plugins.configs.lsp.python")
-- clang
require("plugins.configs.lsp.clang")
