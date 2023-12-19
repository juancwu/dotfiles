local M = {}

---@param opts? ConfigOptions
function M.setup(opts)
    require("juancwu.config").setup(opts)
end

return M
