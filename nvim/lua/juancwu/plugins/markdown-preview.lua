return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    keys = {
        { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle [M]arkdown [P]review" }
    }
}
