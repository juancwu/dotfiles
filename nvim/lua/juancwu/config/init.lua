---@class Config
local M = {}

---@class ConfigOptions
local defaultOpts = {
    ---@type string | fun()
    colorscheme = "rose-pine",
    -- icons used by other plugins
    icons = {
        misc = {
            dots = "󰇘",
        },
        dap = {
            Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint          = " ",
            BreakpointCondition = " ",
            BreakpointRejected  = { " ", "DiagnosticError" },
            LogPoint            = ".>",
        },
        diagnostics = {
            Error = " ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
        },
        git = {
            added    = " ",
            modified = " ",
            removed  = " ",
        },
        kinds = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Codeium       = "󰘦 ",
            Color         = " ",
            Control       = " ",
            Collapsed     = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Copilot       = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Folder        = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Keyword       = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            Reference     = " ",
            Snippet       = " ",
            String        = " ",
            Struct        = "󰆼 ",
            TabNine       = "󰏚 ",
            Text          = " ",
            TypeParameter = " ",
            Unit          = " ",
            Value         = " ",
            Variable      = "󰀫 ",
        },
    },
    ---@type table<string, string[]|boolean>?
    kind_filter = {
        default = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },
        markdown = false,
        help = false,
        -- you can specify a different filter for each filetype
        lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            -- "Package", -- remove package since luals uses it for control flow structures
            "Property",
            "Struct",
            "Trait",
        },
    },
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
        if type(options.colorscheme) == "function" then
            options.colorscheme()
        else
            vim.cmd.colorscheme(options.colorscheme)
        end
    end, function(err)
        local msg = "Failed to load colorscheme " .. options.colorscheme .. "\n\n" .. err
        print(msg)
        vim.cmd.colorscheme("rose-pine")
    end)
end

return M
