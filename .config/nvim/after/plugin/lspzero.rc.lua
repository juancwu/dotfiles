local status, lspzero = pcall(require, "lsp-zero")

if not status then return end

lspzero.preset("recommended")

-- first argument is the client
lspzero.on_attach(function(_, bufnr)
    lspzero.default_keymaps({ buffer = bufnr })

    -- custom keymaps
    vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>") -- format buffer
end)

-- Enable format on save
lspzero.format_on_save({
    format_opts = {
        async = true,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
    }
})

local lspconfig
status, lspconfig = pcall(require, "lspconfig")

if status then
    lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())
end

lspzero.setup()

local cmp
status, cmp = pcall(require, 'cmp')

if not status then return end

cmp.setup({
    mapping = {
        -- Press "Enter" to confirm completion/suggestion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})
