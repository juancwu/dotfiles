local DEBUGGER_PATH = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

return {
    {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        enabled = false,
    },
    {
        'mxsdev/nvim-dap-vscode-js',
        enabled = false,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dapVsCode = require("dap-vscode-js")
            dapVsCode.setup({
                node_path = "node",
                debugger_path = DEBUGGER_PATH,
                adapters = {
                    "pwa-node",
                    "pwa-chrome",
                    "pwa-msedge",
                    "pwa-extensionHost",
                    "node-terminal",
                }
            })

            for _, language in ipairs({ "typescript", "javascript" }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file (node)",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach (node)",
                        processId = require('dap.utils').pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        trace = true,
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                }
            end
        end
    }
}
