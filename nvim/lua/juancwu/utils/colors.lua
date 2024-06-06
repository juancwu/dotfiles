---@class juancwu.utils.colors
local M = {}

---@return boolean
function M.is_daytime()
	local current_hour = tonumber(os.date("%H"))
	return current_hour >= 7 and current_hour < 19
end

---@return string
function M.get_timebased_colorscheme()
	local light = "kanagawa-lotus"
	local dark = "kanagawa-dragon"
	if M.is_daytime() then
		return light
	else
		return dark
	end
end

return M
