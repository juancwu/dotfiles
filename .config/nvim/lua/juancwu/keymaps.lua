vim.g.mapleader = " "

-- open the explorer
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>") 

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- make cursor stay in same position when appending line below
vim.keymap.set("n", "J", "mzJ`z")

-- make cursor stay in the middle while moving down/up the page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- make cursor stay in the middle while looking through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without losing clipboard
vim.keymap.set("x", "<leader>p", "\"_dP")

-- do not copy with x, for god sake, WHY copy something that is being deleted??
vim.keymap.set("n", "x", "\"_x")

-- smile
vim.keymap.set("n", "Q", "<nop>")

-- select and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- no copy, delete line, for god sake...
vim.keymap.set("n", "dd", "\"_dd")
vim.keymap.set("n", "<leader>dd", "dd") -- cut line, under my control

-- copy/paste to/from system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set({"n", "v"}, "<leader>P", "\"+p")

-- increment/decrement a count, helpful for changing indeces
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- do not copy when deleting word
vim.keymap.set("n", "dw", "\"_dw")
vim.keymap.set("n", "de", "\"_de")
vim.keymap.set("n", "<leader>dw", "dw")
vim.keymap.set("n", "<leader>de", "de")

vim.keymap.set("n", "db", "vb\"_d") -- delete in backwards
vim.keymap.set("n", "<leader>db", "vbd")

vim.keymap.set("n", "<C-a>", "gg<S-v>G") -- select all

-- split pane
vim.keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true }) -- horizontal
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true }) -- vertical

-- pane movement
vim.keymap.set("n", "..", "<C-w>w") -- toggle
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")
vim.keymap.set("n", "sj", "<C-w>j")

-- resize pane
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")
