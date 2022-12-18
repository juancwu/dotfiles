local status, zen = pcall(require, "zen-mode")

if not status then return end

zen.setup {}

vim.keymap.set("n", "<C-w>o", vim.cmd.ZenMode, { silent = true })
