return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 300

            local wk = require("which-key")

            wk.setup()
        end,
    }
}
