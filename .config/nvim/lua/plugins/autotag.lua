return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },
    config = function()
        local autotag = require('nvim-ts-autotag')
        autotag.setup()
    end
}
