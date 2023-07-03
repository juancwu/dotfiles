local status, lspzero = pcall(require, "lsp-zero")

if not status then return end

lspzero.preset("recommended")

-- first argument is the client
lspzero.on_attach(function(_, bufnr)
    lspzero.default_keymaps({buffer = bufnr})
end)

lspzero.setup()
