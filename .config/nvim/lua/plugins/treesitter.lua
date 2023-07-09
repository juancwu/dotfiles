return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup {
            -- A list of parser names, or "all"
            ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,
            },

            context_commentstring = {
                enable = true,
            },
        }
    end
}
