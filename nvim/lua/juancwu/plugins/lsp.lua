return {
    -- lspconfig
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required

            -- Neovim Plugin Development Completions
            {
                "folke/neodev.nvim",
                opts = {},
            },

            -- formatting
            {
                "stevearc/conform.nvim",
                config = function()
                    require("conform").setup({
                        formatters_by_ft = {
                            lua = { "stylua" },
                            javascript = { "prettier" },
                            typescript = { "prettier" },
                            javascriptreact = { "prettier" },
                            typescriptreact = { "prettier" },
                            css = { "prettier" },
                            markdown = { "prettier" },
                            go = { "gofumpt" },
                            python = { "autopep8" },
                            yaml = { "yamlfmt" },
                        },
                        format_on_save = function(bufnr)
                            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                                return
                            end
                            return { timeout_ms = 500, lsp_fallback = true }
                        end,
                    })

                    vim.api.nvim_create_user_command("FormatDisable", function()
                        vim.g.disable_autoformat = true
                    end, {
                        desc = "Disable autoformat on save",
                    })

                    vim.api.nvim_create_user_command("FormatEnable", function()
                        vim.g.disable_autoformat = false
                    end, {
                        desc = "Enable autoformat on save",
                    })
                end,
            },
        },
        config = function()
            -- required to setup neodev before lspconfig
            require("neodev").setup({})

            local lspzero = require("lsp-zero")

            lspzero.preset({})

            lspzero.on_attach(function(_, bufnr)
                lspzero.default_keymaps({
                    buffer = bufnr,
                    omit = {
                        "gr",
                    },
                })

                local function nmap(key, action, desc)
                    vim.keymap.set("n", key, action, {
                        desc = "LSP: " .. desc,
                    })
                end

                local function format()
                    require("conform").format({ bufnr = bufnr })
                end

                nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto Prev Diagnostic")
                nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto Next Diagnostic")

                -- local current_dir = vim.fn.expand("%:p:h")

                -- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })

                -- format with space + f
                -- vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<CR>",
                --     { desc = "[F]ormat [B]uffer" })
                nmap("<leader>fb", format, "[F]ormat [B]uffer")

                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    format()
                end, { desc = "Format current buffer with LSP" })
            end)

            local status, lspconfig = pcall(require, "lspconfig")

            if status then
                lspconfig.ts_ls.setup({})
                lspconfig.tailwindcss.setup({
                    filetypes = {
                        "templ",
                        "html",
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                    },
                    init_options = {
                        userLanguages = {
                            templ = "html",
                        },
                    },
                })
                lspconfig.zls.setup({})
                lspconfig.rust_analyzer.setup({})
                lspconfig.gopls.setup({})
                -- lspconfig.html.setup({})
                vim.filetype.add({
                    extension = {
                        templ = "templ",
                    },
                })
                lspconfig.templ.setup({
                    filetypes = {
                        "templ",
                    },
                })
                lspconfig.intelephense.setup({})
            end

            lspzero.setup()

            local cmp
            status, cmp = pcall(require, "cmp")

            if not status then
                return
            end

            cmp.setup({
                mapping = {
                    -- press 'enter' to confirm completion/suggestion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                },
            })
        end,
    },
}
