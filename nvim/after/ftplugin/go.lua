-- quick way to handle errors in Go
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<ESC>Oreturn err<ESC>")
