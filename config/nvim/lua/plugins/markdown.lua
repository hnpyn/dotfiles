return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = {
      "MarkdownPreview", "MarkdownPreviewStop"
    },
    keys = {
            { "<Leader>md", ":MarkdownPreview<CR>", desc = "open markdown preview" },
            { "<Leader>ms", ":MarkdownPreviewStop<CR>", desc = "stop markdown preview" },
            { "<Leader>mt", ":MarkdownPreviewToggle<CR>", desc = "open markdown toggle" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  }
}
