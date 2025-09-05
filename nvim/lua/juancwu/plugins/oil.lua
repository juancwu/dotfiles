return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        local oil = require("oil")

        oil.setup({
            view_options = {
                show_hidden = true,
            },
        })
    end,
    keys = {
        {
            "<leader>oo",
            function()
                require("oil").open()
            end,
            mode = "n",
            desc = "[O]pen [O]il",
        },
    },
}
