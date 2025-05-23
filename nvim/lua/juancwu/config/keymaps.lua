-- easy escape
vim.keymap.set("i", "<C-[>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-[>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-[>", "<Esc>", { noremap = true, silent = true })

-- open the explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>")

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

-- keymap below needs a better combo, need this to enable macros
-- vim.keymap.set("n", "<leader>q", "q", { noremap = true })

-- select and replace
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- do not copy with x, for god sake, WHY copy something that is being deleted??
vim.keymap.set("n", "x", '"_x')

-- no copy, delete line, for god sake...
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "dx", "dd") -- cut line, under my control
vim.keymap.set("v", "d", '"_d')

-- copy/paste to/from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- increment/decrement a count, helpful for changing indeces
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- do not copy when deleting word
vim.keymap.set("n", "dw", '"_dw')
vim.keymap.set("n", "db", 'vb"_d') -- delete in backwards

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

-- my arrow keys babyyyy
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })

-- lazygit on floaterm
vim.keymap.set("n", "<leader>g", "<cmd>FloatermNew lazygit<CR>", { noremap = true })

-- quick way to handle errors in Go
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<ESC>Oreturn err<ESC>")
