return {
    {
        "rose-pine/nvim",
        name = "rose-pine",
        priority = 1000,
        enabled = true,
        config = function()
            vim.cmd.colorscheme("rose-pine")
        end
    },
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end,
    },
}
