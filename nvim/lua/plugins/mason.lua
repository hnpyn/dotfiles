return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",-- :MasonUpdate updates registry contents
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- require("mason").setup()
    end,
  }
}
