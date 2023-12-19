-- vim.opt.clipboard:append { "unnamedplus" }

vim.g.clipboard = {
    name = "xclip",
    copy = {
        ['+'] = "xclip -sel clip -i -quiet",
        ['*'] = "xclip -sel primary -i -quiet",
    },
    paste = {
        ['+'] = "xclip -sel clip -o -quiet",
        ['*'] = "xclip -sel primary -o -quiet",
    },
    cache_enabled = 1,
}
