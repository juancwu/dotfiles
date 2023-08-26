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
          hijack_netrw = false,
          hidden = true,
          mappings = {
            ['i'] = {
              ['<C-w>'] = function() vim.cmd("normal vbd") end,
              ['<C-j>'] = function(bufnr) actions.move_selection_next(bufnr) end,
              ['<C-k>'] = function(bufnr) actions.move_selection_previous(bufnr) end,
              ['<C-s>'] = function(bufnr) actions.select_vertical(bufnr) end,
            },
            ['n'] = {
              ['a'] = fb_actions.create,
              ['h'] = fb_actions.goto_parent_dir,
              ['/'] = function() vim.cmd("startinsert") end,
              ['d'] = fb_actions.remove,
              ['<C-s>'] = function(bufnr) actions.select_vertical(bufnr) end,
              ['<C-a>'] = function(bufnr) actions.toggle_all(bufnr) end,
              ['<C-d>'] = function(bufnr) actions.move_selection_next(bufnr) end,
              ['<C-u>'] = function(bufnr) actions.move_selection_previous(bufnr) end,
            }
          }
        },
      }
    })

    pcall(telescope.load_extension, "file_browser")
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "dap")

    -- Builtin pickers
    vim.keymap.set("n", "<leader>sf", function()
      builtin.find_files({ no_ignore = false, hidden = true })
    end, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]o to [R]eferences", noremap = true })

    -- Git pickers
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "List [G]it [S]tatus" })
    vim.keymap.set("n", "<leader>gh", builtin.git_stash, { desc = "List [G]it [S]tash" })
    vim.keymap.set("n", "<leader>gbb", builtin.git_branches, { desc = "List [G]it [B]ranches" })
    vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "List Buffer [G]it [C]ommits" })

    -- File Browser Ext
    vim.keymap.set("n", "<leader>fs",
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
      end, { desc = "Open [F]ile [S]ystem Menu" })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily serach in current buffer' })
  end
}
