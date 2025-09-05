---@class juancwu.utils.colors
local M = {}
local light = "catppuccin-latte"
local dark = "catppuccin-mocha"

---@return boolean
function M.is_daytime()
  return false
end

---@return boolean
function M.legacy_is_daytime()
  return false
end

---@return string
function M.get_timebased_colorscheme()
  if M.is_daytime() then
    vim.g.is_light_colors = true
    return light
  else
    vim.g.is_light_colors = false
    return dark
  end
end

function M.toggle_colors()
  if vim.g.is_light_colors then
    vim.g.is_light_colors = false
    vim.cmd.colorscheme(dark)
  else
    vim.g.is_light_colors = true
    vim.cmd.colorscheme(light)
  end
end

return M
