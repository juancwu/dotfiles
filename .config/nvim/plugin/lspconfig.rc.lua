local status, nvim_lsp = pcall(require, 'lspconfig')

if (not status) then return end

local protocol = require('vim.lsp.protocol')

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- mappings
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = {
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      enable_format_on_save(client, bufnr)
    end,
    settings = {
        Lua = {
            diagnostics = {
                -- get the language server to recognize the 'vim' global
                globals = { 'vim' }
            },

            workspace = {
                -- make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
nvim_lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
nvim_lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- lsp signature help
local signature_opts = {
    floating_window = false,
    -- toggle_key = '<C-i>'
}
require 'lsp_signature'.setup(signature_opts)
