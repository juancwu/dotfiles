vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local juancwu_fugitive = vim.api.nvim_create_augroup("juancwu_fugitive", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = juancwu_fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>p", function ()
            vim.cmd.Git("push")
        end, opts)

        vim.keymap.set("n", "<leader>P", function ()
            vim.cmd.Git({"pull", "--rebase"})
        end, opts)

        -- setup an upstream for first pushes to a branch
        vim.keymap.set("n", "<leader>u", ":Git push -u origin ", opts)
    end
})
