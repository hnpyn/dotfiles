return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    cmd = {
      "Telescope"
    },
    keys = {
      { "<Leader>ff", ":Telescope find_files<CR>", desc = "find files" },
      { "<Leader>fg", ":Telescope live_grep<CR>", desc = "live grep" },
      { "<Leader>fb", ":Telescope buffers<CR>", desc = "buffers" },
      { "<Leader>fr", ":Telescope resume<CR>", desc = "resume" },
      { "<Leader>fo", ":Telescope oldfiles<CR>", desc = "old files" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  }
}
