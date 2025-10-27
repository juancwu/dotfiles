return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        local comment = require("Comment")
        comment.setup({
            pre_hook = function(ctx)
                -- only for tsx/jsx filetypes
                if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
                    local U = require("Comment.utils")

                    -- determine wheter to use linwise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

                    -- determine the location where to calcualte commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = require("ts_context_commentstring.utils").get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require("ts_context_commentstring.utils").get_visual_start_location()
                    end

                    return require("ts_context_commentstring.internal").calculate_commentstring({
                        key = type,
                        location = location,
                    })
                end
            end,
        })
    end,
}
