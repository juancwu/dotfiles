return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        {                            -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
        local lspzero = require("lsp-zero")

        lspzero.preset("recommended")

        lspzero.on_attach(function(client, bufnr)
            lspzero.default_keymaps({ buffer = bufnr })

            -- format with space + f
            vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>")
        end)

        lspzero.ensure_installed({
            "tsserver",
            "eslint",
            "tailwindcss",
        })

        lspzero.format_on_save({
            format_ops = {
                async = true,
                timeout_ms = 10000,
            },
            servers = {
                ["lua_ls"] = { "lua" },
                ["null-ls"] = {
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                },
            },
        })

        local status, lspconfig = pcall(require, "lspconfig")

        if status then
            lspconfig.tsserver.setup({})
            lspconfig.tailwindcss.setup({})
        end

        lspzero.setup()

        local cmp
        status, cmp = pcall(require, "cmp")

        if not status then return end

        cmp.setup({
            mapping = {
                -- press 'enter' to confirm completion/suggestion
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.abort(),
            },
        })
    end
}
