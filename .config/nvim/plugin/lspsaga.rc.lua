local status, saga = pcall(require, 'lspsaga')
if not status then return end

saga.init_lsp_saga {
    server_filetype_map = {}
}


local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
-- signature_help has been removed
-- vim.api.nvim_set_keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.api.nvim_set_keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
