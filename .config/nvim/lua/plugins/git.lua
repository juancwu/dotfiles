return {
    'dinhhuy258/git.nvim',
    keys = {
        { "<leader>gbl", "<cmd>GitBlame<CR>", desc = "Open [G]it [Bl]ame" },
        { "<leader>gd",  "<cmd>GitDiff<CR>",  desc = "Open [G]it [D]iff" },
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
                quit_blame = "q",
                diff_close = "q",
            },
            target_branch = "main",

        })
    end
}
