return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            options = {
                icons_enabled = false,
                --[[ section_separators = {
                    left = '',
                    right = ''
                },
                component_separators = {
                    left = '',
                    right = ''
                }, ]]
                section_separators = "",
                component_separators = "|",
                disabled_filetypes = {},
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        file_status = true, -- display file status
                        path = 1, -- no file path
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = "" },
                    },
                    "enconding",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "fugitive" },
        })
    end,
}
