---@type vim.lsp.Config
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "templ" },
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "package.json",
        ".git",
    },
    init_options = {
        userLanguages = {
            templ = "html",
        },
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            includeLanguages = {
                templ = "html",
            },
        },
    },
}
