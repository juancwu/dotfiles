return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },
    ft = {
        "javascriptreact",
        "typescriptreact",
        "html"
    },
    config = function()
        local autotag = require('nvim-ts-autotag')
        autotag.setup()
    end
}
