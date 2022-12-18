local status, mark = pcall(require, "harpoon.mark")

if not status then return end

local status, ui = pcall(require, "harpoon.ui")

if not status then return end

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>q", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>w", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>e", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>r", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>,", ui.nav_prev)
vim.keymap.set("n", "<leader>.", ui.nav_next)
