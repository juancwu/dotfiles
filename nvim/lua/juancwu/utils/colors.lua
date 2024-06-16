---@class juancwu.utils.colors
local M = {}
local light = "catppuccin-latte"
local dark = "catppuccin-mocha"

---@return boolean
function M.is_daytime()
	-- check if command exists or not
	local cmd_name = "asadesuka"
	local cmd_flags = "-offset 30"
	local has_asadesuka = require("juancwu.utils.os").cmd_exists(cmd_name)
	if has_asadesuka then
		local handle = io.popen(cmd_name .. " " .. cmd_flags)
		if handle == nil then
			return M.legacy_is_daytime()
		end
		local result = handle:read("*a")
		handle:close()
		return result:match("true")
	else
		return M.legacy_is_daytime()
	end
end

---@return boolean
function M.legacy_is_daytime()
	local current_hour = tonumber(os.date("%h"))
	return current_hour >= 7 and current_hour < 19
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
