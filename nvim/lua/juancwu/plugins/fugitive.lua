return {
    "tpope/vim-fugitive",
    cmd = {
        "Git",
        "G",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "Ggrep",
        "GMove",
        "GDelete",
        "GBrowse",
        "GRemove",
        "GRename",
        "Glgrep",
        "Gedit"
    },
    keys = {
        { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
        { "<leader>gbl", "<cmd>Git blame<CR>", desc = "Open [G]it [Bl]ame" },
        { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Open [G]it [D]iff" },
    },
}