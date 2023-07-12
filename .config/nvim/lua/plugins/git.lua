return {
    'dinhhuy258/git.nvim',
    keys = {
        { "<leader>gb", "<cmd>GitBlame<CR>",   desc = "Open Git Blame" },
        { "<leader>gd", "<cmd>GitDiff<CR>",    desc = "Open Git Diff" },
        { "<leader>gs", "<cmd>Git status<CR>", desc = "Open Git Status" }
    },
    cmd = {
        "Git",
        "GitBlame",
        "GitDiff",
    },
    config = function()
        local git = require('git')

        git.setup({
            default_keymaps = true,
            keymaps = {
                blame = "<leader>gb",
                quit_blame = "q",
                diff = "<leader>gd",
                diff_close = "q",
            },
            target_branch = "main",

        })
    end
}
