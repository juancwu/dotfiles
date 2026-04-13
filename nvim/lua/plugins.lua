-- blink blink dependencies
vim.pack.add({ { src = "https://github.com/nvim-mini/mini.icons.git" } })
require("mini.icons").setup()

-- mason for easy install of lsp, formatters, etc
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

-- mason setup
require("mason").setup({})

-- see git blame, diff in editor
vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim", version = "v2.1.0" },
})

require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
    },
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
    },
})

-- autocomplete
vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})

require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },

    sources = { default = { "lsp" } },
})

-- filesystem navigation
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim.git", version = "v2.15.0" },
})

require("oil").setup({
    columns = {
        "icon",
    },
    view_options = {
        show_hidden = true,
    },
})

-- formatting
vim.pack.add({
    {
        src = "https://github.com/stevearc/conform.nvim.git",
        version = "v9.1.0",
    },
})

local formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    css = { "biome" },
    markdown = { "biome" },
    jsonc = { "biome" },
    json = { "biome" },
    go = { "gofmt", "goimports" },
    python = { "autopep8" },
    yaml = { "yamlfmt" },
    yml = { "yamlfmt" },
    zig = { "zigfmt" },
    rust = { "rustfmt" },
    templ = { "templ" },
    php = { "pint" },
    blade = { "blade-formatter" },
}

require("conform").setup({
    notify_on_error = false,
    formatters_by_ft = formatters_by_ft,
    formatters = {
        pint = {
            command = "vendor/bin/pint",
            args = { "$FILENAME" },
            stdin = false,
        },
        ["blade-formatter"] = {
            command = "blade-formatter",
            args = {
                "--write",
                "--stdin",
            },
        },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return {
            timeout_ms = 2500,
            lsp_format = "fallback",
        }
    end,
})

-- tree-sitter
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
        version = "4916d6592ede8c07973490d9322f187e07dfefac",
    },
})
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git",
        version = "851e865342e5a4cb1ae23d31caf6e991e1c99f1e",
    },
})

-- floating windows
vim.pack.add({
    {
        src = "https://github.com/akinsho/toggleterm.nvim.git",
        version = "v2.13.1",
    },
})

require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- show indentation group
vim.pack.add({
    {
        src = "https://github.com/nvim-mini/mini.indentscope.git",
        version = "v0.17.0",
    },
})

require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
})

-- telescope
vim.pack.add({
    {
        src = "https://github.com/nvim-lua/plenary.nvim.git",
        version = "v0.1.4",
    },
})
vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope.nvim.git",
        version = "v0.2.2",
    },
})
vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
        version = "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c",
    },
})
vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope-file-browser.nvim.git",
        version = "3610dc7dc91f06aa98b11dca5cc30dfa98626b7e",
    },
})
vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git",
        version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
    },
})

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Build telescope-fzf-native.nvim",
    callback = function(ev)
        local data = ev.data
        if
            data
            and data.spec
            and data.spec.name == "telescope-fzf-native.nvim"
            and (data.kind == "install" or data.kind == "update")
            and vim.fn.executable("make") == 1
        then
            vim.system({ "make" }, { cwd = data.path }):wait()
        end
    end,
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
        file_browser = {
            theme = "dropdown",
            hijack_netrw = false,
            hidden = true,
            mappings = {
                ["i"] = {
                    ["<C-w>"] = function()
                        vim.cmd("normal vbd")
                    end,
                    ["<C-j>"] = function(bufnr)
                        actions.move_selection_next(bufnr)
                    end,
                    ["<C-k>"] = function(bufnr)
                        actions.move_selection_previous(bufnr)
                    end,
                    ["<C-s>"] = function(bufnr)
                        actions.select_vertical(bufnr)
                    end,
                },
                ["n"] = {
                    ["a"] = fb_actions.create,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["/"] = function()
                        vim.cmd("startinsert")
                    end,
                    ["d"] = fb_actions.remove,
                    ["e"] = fb_actions.change_cwd,
                    ["<C-s>"] = function(bufnr)
                        actions.select_vertical(bufnr)
                    end,
                    ["<C-a>"] = function(bufnr)
                        actions.toggle_all(bufnr)
                    end,
                    ["<C-d>"] = function(bufnr)
                        actions.move_selection_next(bufnr)
                    end,
                    ["<C-u>"] = function(bufnr)
                        actions.move_selection_previous(bufnr)
                    end,
                },
            },
        },
    },
})

pcall(telescope.load_extension, "file_browser")
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")
