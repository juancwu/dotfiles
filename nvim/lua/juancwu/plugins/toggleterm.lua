return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<leader>lg", function() 
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                direction = "float",
                float_opts = {
                    border = "double",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            lazygit:toggle()
        end, desc = "Open lazygit in a floating window" },
    },
    opts = {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
}