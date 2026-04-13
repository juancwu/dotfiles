-- easy escape
vim.keymap.set("i", "<C-[>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-[>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-[>", "<Esc>", { noremap = true, silent = true })

-- open the explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>")

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- make cursor stay in same position when appending line below
vim.keymap.set("n", "J", "mzJ`z")

-- make cursor stay in the middle while moving down/up the page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- make cursor stay in the middle while looking through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- select and replace
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- do not copy with x, for god sake, WHY copy something that is being deleted??
vim.keymap.set("n", "x", '"_x')

-- no copy, delete line, for god sake...
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "dx", "dd") -- cut line, under my control
vim.keymap.set("v", "d", '"_d')

-- copy/paste to/from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- increment/decrement a count, helpful for changing indeces
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- do not copy when deleting word
vim.keymap.set("n", "dw", '"_dw')
vim.keymap.set("n", "db", 'vb"_d') -- delete in backwards

vim.keymap.set("n", "<C-a>", "gg<S-v>G") -- select all

-- split pane
vim.keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true }) -- horizontal
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true }) -- vertical

-- pane movement
vim.keymap.set("n", "..", "<C-w>w") -- toggle
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")
vim.keymap.set("n", "sj", "<C-w>j")

-- resize pane
vim.keymap.set("n", "<C-w><left>", "<C-w>5>")
vim.keymap.set("n", "<C-w><right>", "<C-w>5<")
vim.keymap.set("n", "<C-w><up>", "<C-w>5+")
vim.keymap.set("n", "<C-w><down>", "<C-w>5-")

-- lazygit on floaterm
vim.keymap.set("n", "<leader>lg", function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        float_opts = {
            border = "double",
        },
        on_open = function(term)
            vim.cmd("startinsert!")
        end,
        on_close = function(term)
            vim.cmd("startinsert!")
        end,
    })
    lazygit:toggle()
end, { desc = "Open lazygit in a floating window" })

-- built-in package manager update
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")

-- oil.nvim
vim.keymap.set("n", "<leader>oo", "<cmd>Oil<CR>")

-- conform.nvim
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<CR>")

-- telescope
local telescope = require("telescope")
local builtin = require("telescope.builtin")

local function get_fd_command()
    if vim.fn.executable("fd") == 1 then
        return "fd"
    elseif vim.fn.executable("fdfind") == 1 then
        return "fdfind"
    end
    return nil
end

local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
end

-- Builtin pickers
vim.keymap.set("n", "<leader>sf", function()
    local fd_cmd = get_fd_command()
    local config = {
        hidden = true,
        file_ignore_patterns = {
            "node%_modules/.*",
            "%.git/.*",
            "%.rustup/.*",
            "target/.*",
            ".devbox/.*",
            ".nix/.*",
            "vendor/.*",
            "storage/.*",
        },
    }

    if fd_cmd then
        config.find_command = {
            fd_cmd,
            "--type",
            "f",
            "--color",
            "never",
            "--hidden",
            "--no-ignore",
        }
    end

    builtin.find_files(config)
end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

-- Git pickers
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "List [G]it [S]tatus" })
vim.keymap.set("n", "<leader>gh", builtin.git_stash, { desc = "List [G]it [S]tash" })
vim.keymap.set("n", "<leader>gbb", builtin.git_branches, { desc = "List [G]it [B]ranches" })
vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "List Buffer [G]it [C]ommits" })

-- File Browser Ext
vim.keymap.set("n", "<leader>fs", function()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
    })
end, { desc = "Open [F]ile [S]ystem Menu" })

vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily serach in current buffer" })

-- live grep in open files only
vim.keymap.set("n", "<leader>s/", function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, { desc = "[S]search [/] in Open Files" })

-- shortcut for searching neovim config files
vim.keymap.set("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
