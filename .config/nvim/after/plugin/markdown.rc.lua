local juancwu_markdown = vim.api.nvim_create_augroup("juancwu_markdown", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = juancwu_markdown,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "markdown" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<C-m>p", vim.cmd.MarkdownPreview, opts)
        vim.keymap.set("n", "<C-m>s", vim.cmd.MarkdownPreviewStop, opts)
        vim.keymap.set("n", "<C-m>t", vim.cmd.MarkdownPreviewToggle, opts)
    end
})
