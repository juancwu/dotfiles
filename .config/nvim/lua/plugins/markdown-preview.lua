return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Toggle [M]arkdown [P]review" }
  }
}
