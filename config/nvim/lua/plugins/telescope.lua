return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    cmd = { "Telescope" },
    keys = {
      { "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Telescope: find files" },
      { "<Leader>fg", "<Cmd>Telescope live_grep<CR>",  desc = "Telescope: live grep" },
      { "<Leader>fb", "<Cmd>Telescope buffers<CR>",    desc = "Telescope: buffers" },
      { "<Leader>fr", "<Cmd>Telescope resume<CR>",     desc = "Telescope: resume" },
      { "<Leader>fo", "<Cmd>Telescope oldfiles<CR>",   desc = "Telescope: old files" },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },
}
