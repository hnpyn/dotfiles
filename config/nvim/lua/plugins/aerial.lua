return {
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        disable_max_lines = 1000,
        disable_max_size = 102400,
        layout = { min_width = 28 },
        show_guides = true,
        filter_kind = false,
        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },
        keymaps = {
          ["[y"] = "actions.prev",
          ["]y"] = "actions.next",
          ["[Y"] = "actions.prev_up",
          ["]Y"] = "actions.next_up",
          ["{"] = false,
          ["}"] = false,
          ["[["] = false,
          ["]]"] = false,
        },
      })
      vim.keymap.set("n", "<Leader>a", "<Cmd>AerialToggle!<CR>")
    end,
  },
}
