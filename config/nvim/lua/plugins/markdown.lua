return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = {
      "MarkdownPreview", "MarkdownPreviewStop"
    },
    keys = {
            { "<Leader>md", "<Cmd>MarkdownPreview<CR>", desc = "open markdown preview" },
            { "<Leader>ms", "<Cmd>MarkdownPreviewStop<CR>", desc = "stop markdown preview" },
            { "<Leader>mt", "<Cmd>MarkdownPreviewToggle<CR>", desc = "open markdown toggle" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  }
}
