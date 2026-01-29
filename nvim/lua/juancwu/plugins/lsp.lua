return {
    -- lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {

        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },

        { "saghen/blink.cmp" },
    },
    config = function()
        -- stole this from kickstart, great config
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- This is the helper function to set keymaps locally for this buffer
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Use built-in LSP for definitions (replaces deprecated Telescope function)
                map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

                -- Use Telescope for references (auto-closes on selection)
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Use built-in LSP for implementation (replaces deprecated Telescope function)
                map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

                -- Use built-in LSP for type definitions (replaces deprecated Telescope function)
                map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

                -- Telescope for document symbols (this is a good use for Telescope)
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Telescope for workspace symbols (also a good use for Telescope)
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Built-in LSP for renaming
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Built-in LSP for code actions
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                -- Built-in LSP for declaration
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Built-in LSP for diagnostics
                map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
                map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

        vim.filetype.add({
            extension = {
                templ = "templ",
            },
        })

        local servers = {
            ts_ls = {},
            gopls = {},
            zls = {},
            rust_analyzer = {},
            templ = {
                filetypes = { "templ" },
            },
            intelephense = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            cssls = {},
            css_variables = {},
            tailwindcss = {
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
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, { "stylua", "yamlfmt", "biome", "goimports" })
        -- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        local profiles = {
            base = { "yamlfmt" },
            lua = { "lua_ls", "stylua" },
            web = { "ts_ls", "tailwindcss", "biome", "intelephense", "templ", "cssls", "css_variables" },
            go = { "gopls", "goimports" },
            rust = { "rust_analyzer" },
            zig = { "zls" },
            all = ensure_installed,
        }

        vim.api.nvim_create_user_command("InstallProfile", function(opts)
            local profile_name = opts.args
            local tools = profiles[profile_name]

            if not tools then
                print(
                    "Profile '"
                        .. profile_name
                        .. "' not found. Available: "
                        .. table.concat(vim.tbl_keys(profiles), ", ")
                )
                return
            end

            require("mason-tool-installer").setup({ ensure_installed = tools })
            vim.cmd("MasonToolsInstall")
        end, {
            desc = "Install tools for a specific profile (e.g., web, lua, go)",
            nargs = 1,
            complete = function()
                return vim.tbl_keys(profiles)
            end,
        })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
