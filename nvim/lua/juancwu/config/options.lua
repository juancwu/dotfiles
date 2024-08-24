vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true         -- show line number
vim.opt.relativenumber = true -- juicy relativity

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.breakindent = true

vim.opt.wrap = false -- bad, stay away from me!

vim.opt.hlsearch = false
vim.opt.incsearch = true -- highlight search pattern as you type

vim.opt.scrolloff = 12   -- give me some personal space

vim.opt.updatetime = 50

vim.opt.ignorecase = true -- case-insensitive search

vim.opt.backspace = { "start", "eol", "indent" }

-- don't want to look into these...
vim.opt.wildignore:append({ "*/node_modules/*", "*/__pycache__/*" })

-- add '*' in block comments
vim.opt.formatoptions:append({ "r" })

-- theme
vim.opt.winblend = 0
vim.opt.wildoptions = "pum" -- show popup for autocomplete
vim.opt.pumblend = 5
vim.opt.background = "dark"
vim.opt.termguicolors = true -- good shit, just take it

-- activate persistent undo
vim.opt.undofile = true

-- highlight on yank
local highligh_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highligh_group,
    pattern = "*",
})

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.breakindent = true

vim.opt.cursorline = true

-- for obsidian
vim.opt.conceallevel = 2
