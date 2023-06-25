return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    version = "*",
    -- event = "VeryLazy",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<Leader>]", "<Cmd>BufferLineCycleNext<CR>", desc = "next buffer" },
      { "<Leader>[", "<Cmd>BufferLineCyclePrev<CR>", desc = "prev buffer" },
      { "<Leader>C", "<Cmd>BufferLinePickClose<CR>", desc = "close buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          -- 左侧让出 nvim-tree 的位置
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
          -- separator_style = "slant",
        },
      })
    end,
  },
}
