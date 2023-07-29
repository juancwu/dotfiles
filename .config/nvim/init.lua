local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_unix = has "unix"

-- custom modules:
require("keymaps")
require("options")

if is_win then
	require("clipboard-windows")
end

if is_mac then
	require("clipboard-macos")
end

if is_unix then
	require("clipboard-unix")
end

require("lazy").setup("plugins")
