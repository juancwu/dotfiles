local status, telescope = pcall(require, "telescope")

if not status then return end

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
                    ['<C-w>'] = function() vim.cmd("normal vbd") end
                },
                ['n'] = {
                    ['N'] = fb_actions.create,
                    ['h'] = fb_actions.goto_parent_dir,
                    ['/'] = function() vim.cmd("startinsert") end,
                    ['D'] = fb_actions.remove
                }
            }
        }
    }
})

telescope.load_extension("file_browser")


-- Set up keymaps specific to telescope
vim.keymap.set("n", ";f", function()
    builtin.find_files({ no_ignore = false, hidden = true })
end)
vim.keymap.set("n", ";g", builtin.git_files)
vim.keymap.set("n", "sf", 
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
vim.keymap.set("n", ";h", builtin.help_tags)
