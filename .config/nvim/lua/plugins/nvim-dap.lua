return {
    'mfussenegger/nvim-dap',
    config = function()
        local status, wk = pcall(require, "which-key")

        local dap_breakpoints = {
            breakpoint = {
                text = "",
                texthl = "LspDiagnosticsSignError",
                linehl = "",
                numhl = "",
            },
            rejected = {
                text = "",
                texthl = "LspDiagnosticsSignHint",
                linehl = "",
                numhl = "",
            },
            stopped = {
                text = "",
                texthl = "LspDiagnosticsSignInformation",
                linehl = "DiagnosticUnderlineInfo",
                numhl = "LspDiagnosticsSignInformation",
            },
        }

        vim.fn.sign_define("DapBreakpoint", dap_breakpoints.breakpoint)
        vim.fn.sign_define("DapStopped", dap_breakpoints.stopped)
        vim.fn.sign_define("DapBreakpointRejected", dap_breakpoints.rejected)

        if not status then
            local function nmap(key, action, desc)
                vim.keymap.set(
                    "n",
                    "<leader>d" .. key,
                    action,
                    {
                        desc = "[D]AP: " .. desc,
                        noremap = true,
                        nowait = false,
                        silent = true
                    }
                )
            end

            nmap("c", "<cmd>lua require'dap'.continue()<CR>", "[C]ontinue")
            nmap("b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle [B]reakpoint")
            nmap("i", "<cmd>lua require'dap'.step_into()<CR>", "Step [I]nto")
            nmap("o", "<cmd>lua require'dap'.step_over()<CR>", "Step [O]ver")
            nmap("u", "<cmd>lua require'dap'.step_out()<CR>", "[U] Step Out")
            nmap("x", "<cmd>lua require'dap'.terminate()<CR>", "[T]erminate")
            nmap("q", "<cmd>lua require'dap'.close()<CR>", "[Q]uit")
        else
            local keymap = {
                d = {
                    name = "DAP",
                    c = { "<cmd>lua require'dap'.continue()<CR>", "[C]ontinue" },
                    b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle [B]reakpoint" },
                    i = { "<cmd>lua require'dap'.step_into()<CR>", "Step [I]nto" },
                    o = { "<cmd>lua require'dap'.step_over()<CR>", "Step [O]ver" },
                    u = { "<cmd>lua require'dap'.step_out()<CR>", "[U] Step Out" },
                    x = { "<cmd>lua require'dap'.terminate()<CR>", "[T]erminate" },
                    q = { "<cmd>lua require'dap'.close()<CR>", "[Q]uit" },
                },
            }

            local opts = {
                mode = "n",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
            }
            wk.register(keymap, opts)
        end
    end
}
