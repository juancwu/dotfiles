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

-- custom modules:
require("keymaps")
require("clipboard")
require("options")

require("lazy").setup({
    import = "plugins",
    install = {
        colorscheme = { "rose-pine" },
    }
})

-- set theme
vim.cmd.colorscheme("rose-pine")
