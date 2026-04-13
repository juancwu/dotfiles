-- Workaround for Neovim 0.12 bug: vim/lsp/document_color.lua#get_hex_code
-- doesn't clamp lsp.Color channels, so a server returning a channel slightly
-- above 1.0 produces a malformed 7-char hex (e.g. "#1006467") and crashes
-- get_contrast_color. Clamp channels before the upstream handler runs.
do
    require("vim.lsp.document_color")
    local Provider = require("vim.lsp._capability").all.document_color
    local orig_handler = Provider.handler
    Provider.handler = function(self, err, result, ctx)
        if type(result) == "table" then
            for _, res in ipairs(result) do
                local c = res and res.color
                if c then
                    c.red = math.max(0, math.min(1, tonumber(c.red) or 0))
                    c.green = math.max(0, math.min(1, tonumber(c.green) or 0))
                    c.blue = math.max(0, math.min(1, tonumber(c.blue) or 0))
                    if c.alpha ~= nil then
                        c.alpha = math.max(0, math.min(1, tonumber(c.alpha) or 0))
                    end
                end
            end
        end
        return orig_handler(self, err, result, ctx)
    end
end

vim.lsp.enable({
    "bashls",
    "cssls",
    "css_variables",
    "gopls",
    "html",
    "lua_ls",
    "rust-analyzer",
    "tailwindcss",
    "templ",
    "ts_ls",
})
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("juancwu-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to previous diagnostic")
        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next diagnostic")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("juancwu-lsp-highlight", { clear = false })
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
                group = vim.api.nvim_create_augroup("juancwu-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "juancwu-lsp-highlight", buffer = event2.buf })
                end,
            })
        end
    end,
})
