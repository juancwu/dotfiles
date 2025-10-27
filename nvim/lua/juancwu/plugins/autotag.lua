return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    ft = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "xml",
        "php",
        "markdown",
        "astro",
        "glimmer",
        "handlebars",
        "hbs",
        "templ",
    },
    config = function()
        local autotag = require("nvim-ts-autotag")
        autotag.setup({
            enable = true,
            enable_close_on_slash = false,
        })
    end,
}
