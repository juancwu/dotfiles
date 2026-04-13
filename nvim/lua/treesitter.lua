local treesitter = require("nvim-treesitter")

treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
    autotag = {
        enable = false,
        enable_close_on_slash = false,
    },
})

-- Install parsers
local ensured_installed = {
    "go",
    "gosum",
    "gomod",
    "rust",
    "c",
    "php",
    "blade",
    "javascript",
    "typescript",
    "lua",
    "templ",
}
local already_installed = treesitter.get_installed()
local parsers_to_install = vim.iter(ensured_installed)
    :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()
treesitter.install(parsers_to_install)

-- highlighting and indentation
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- textobjects
-- Disable entire built-in ftplugin mappings to avoid conflicts.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
vim.g.no_plugin_maps = true
require("nvim-treesitter-textobjects").setup({})
