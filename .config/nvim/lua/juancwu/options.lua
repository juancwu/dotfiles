vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true -- show line number
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

vim.opt.scrolloff = 8 -- give me some personal space

vim.opt.updatetime = 50

vim.opt.ignorecase = true -- case-insensitive search

vim.opt.backspace = { "start", "eol", "indent" }

-- don't want to look into these...
vim.opt.wildignore:append { "*/node_modules/*", "*/__pycache__/*" } 

-- add '*' in block comments
vim.opt.formatoptions:append { 'r' }

-- theme
vim.opt.winblend = 0
vim.opt.wildoptions = "pum" -- show popup for autocomplete
vim.opt.pumblend = 5
vim.opt.background = "dark"
vim.opt.termguicolors = true -- good shit, just take it
