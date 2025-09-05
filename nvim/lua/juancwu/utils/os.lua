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

---@param cmd string
---@return boolean
function M.cmd_exists(cmd)
  local handle = io.popen("command -v " .. cmd)
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    return #result > 0
  else
    return false
  end
end

return M
