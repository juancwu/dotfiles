---@class Config: ConfigOptions
local M = {}

---@class ConfigOptions
local defaultOpts = {
    ---@type string | fun()
    colorscheme = "rose-pine",
}

---@param name "options" | "keymaps" | "clipboard"
function M.load(name)
    local mod = "juancwu.config." .. name
    local error_handler = function(err)
        local msg = "Failed loading " .. mod .. "\n\n" .. err
        print(msg)
    end
    xpcall(function()
        require(mod)
    end, error_handler)
end

---@type ConfigOptions
local options

---@param opts? ConfigOptions
function M.setup(opts)
    options = vim.tbl_deep_extend("force", defaultOpts, opts or {}) or {}

    M.load("options")
    M.load("keymaps")
    M.load("clipboard")

    require("lazy").setup("juancwu.plugins")

    -- try to load colorscheme
    xpcall(function()
        if type(M.colorscheme) == "function" then
            M.colorscheme()
        else
            vim.cmd.colorscheme(M.colorscheme)
        end
    end, function(err)
        if type(M.colorscheme) == "string" then
            local msg = "Failed to load colorscheme " .. M.colorscheme .. "\n\n" .. err
            print(msg)
        else
            print("Failed to load colorscheme\n\n" .. err)
        end
        vim.cmd.colorscheme("rose-pine")
    end)
end

setmetatable(M, {
    __index = function(_, k)
        if options == nil then
            return vim.deepcopy(defaultOpts)[k]
        end

        return options[k]
    end
})

return M
