local status, lsp = pcall(require, "lsp-zero")

if not status then return end

lsp.preset("recommended")
lsp.setup()

lsp.on_attach(function(_, buffnr)
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = buffnr })
end)
