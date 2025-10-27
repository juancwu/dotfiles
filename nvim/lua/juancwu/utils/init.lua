---@class Utils
---@field os juancwu.utils.os
local M = setmetatable({}, {
    __index = function(t, k)
        t[k] = require("juancwu.utils." .. k)
        return t[k]
    end,
})

return M
