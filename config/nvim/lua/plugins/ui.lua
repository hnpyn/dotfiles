return {
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = { default_prompt = "➤ " },
      select = { backend = { "telescope", "builtin", "nui" } },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerToggle",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    opts = { user_default_options = { names = false } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("indent_blankline").setup({
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 5,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
