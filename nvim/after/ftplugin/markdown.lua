local map = vim.keymap.set

map("v", "<leader>ln", "<CMD>ObsidianLinkNew<CR>")
map("n", "<C-n>", "<CMD>ObsidianNew<CR>")
map("n", "<leader>of", "<CMD>ObsidianSearch<CR>")
map("n", "<leader>ll", "<CMD>ObsidianLinks<CR>")
map("n", "<C-]>", "<CMD>ObsidianFollowLink<CR>")
