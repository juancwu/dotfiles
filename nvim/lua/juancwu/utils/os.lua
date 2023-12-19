---@class juancwu.utils.os
local M = {}

---@return boolean
function M.is_linux()
    return vim.loop.os_uname().sysname:find("Linux") ~= nil
end

---@return boolean
function M.is_mac()
    return vim.loop.os_uname().sysname:find("Darwin") ~= nil
end

---@return boolean
function M.is_win()
    return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

---@return boolean
function M.is_wsl()
    return vim.fn.has("wsl") == 1
end

return M
