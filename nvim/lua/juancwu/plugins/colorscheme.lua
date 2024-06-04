return {
    -- rose-pine
    {
        "rose-pine/nvim",
        name = "rose-pine",
        priority = 1000,
    },

    -- onedark
    {
        'navarasu/onedark.nvim',
        priority = 1000,
    },

    -- solarized-osaka
    {
        "craftzdog/solarized-osaka.nvim",
        priority = 1000,
        opts = {
            transparent = false,
        }
    },

    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
    },

    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
        },
    },
}
