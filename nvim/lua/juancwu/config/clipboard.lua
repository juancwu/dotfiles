local Utils = require("juancwu.utils")

if Utils.os.is_linux() then
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
elseif Utils.os.is_mac() then
    vim.opt.clipboard:append { "unnamedplus" }
elseif Utils.os.is_wsl() then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ['+'] = "win32yank.exe -i --crlf",
            ['*'] = "win32yank.exe -i --crlf",
        },
        paste = {
            ['+'] = "win32yank.exe -o --lf",
            ['*'] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
    }
end
