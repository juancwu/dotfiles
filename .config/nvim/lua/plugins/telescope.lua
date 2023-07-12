return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local fb_actions = require "telescope".extensions.file_browser.actions

        local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
        end

        telescope.setup({
            defaults = {
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                }
            },
            extensions = {
                file_browser = {
                    theme = "dropdown",
                    hijack_netrw = true,
                    hidden = true,
                    mappings = {
                        ['i'] = {
                            ['<C-w>'] = function() vim.cmd("normal vbd") end,
                            ['<C-j>'] = function(bufnr) actions.move_selection_next(bufnr) end,
                            ['<C-k>'] = function(bufnr) actions.move_selection_previous(bufnr) end,
                            ['<C-s>'] = function(bufnr) actions.select_vertical(bufnr) end,
                        },
                        ['n'] = {
                            ['N'] = fb_actions.create,
                            ['h'] = fb_actions.goto_parent_dir,
                            ['/'] = function() vim.cmd("startinsert") end,
                            ['D'] = fb_actions.remove,
                            ['<C-s>'] = function(bufnr) actions.select_vertical(bufnr) end,
                            ['<C-a>'] = function(bufnr) actions.toggle_all(bufnr) end,
                        }
                    }
                },
            }
        })

        telescope.load_extension("file_browser")

        -- Set up keymaps specific to telescope
        vim.keymap.set("n", ";f", function()
            builtin.find_files({ no_ignore = false, hidden = true })
        end)
        vim.keymap.set("n", ";g", builtin.git_files)
        vim.keymap.set("n", ";h", builtin.help_tags)
        vim.keymap.set("n", ";d",
            function()
                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = true,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 }
                })
            end)

        local status, wk = pcall(require, "which-key");
        if status then
            wk.register({
                [";"] = {
                    name = "Telescope",
                    f = { desc = "Search files in project" },
                    d = { desc = "Open directory viewer" },
                    g = { desc = "Search git files" },
                    h = { desc = "Search help tags" },
                }
            })
        end
    end
}
