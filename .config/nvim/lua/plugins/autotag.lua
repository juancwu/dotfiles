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
    autotag.setup({
      enable = true,
      enable_close_on_slash = false,
    })
  end
}
