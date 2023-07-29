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
local is_wsl = has "wsl"
local is_unix = has "unix"

-- custom modules:
require("keymaps")
require("options")

if is_wsl == 1 then
	require("clipboard-wsl")
end

if is_mac == 1 then
	require("clipboard-macos")
end

if is_unix == 1 then
	require("clipboard-unix")
end

require("lazy").setup("plugins")
