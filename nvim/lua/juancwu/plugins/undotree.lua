return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
  },
  config = function()
    local has_persistent_undo = vim.api.nvim_call_function("has", { "persistent_undo" })

    if has_persistent_undo then
      local target_path = vim.api.nvim_call_function("expand", { "~/.undodir" })

      local is_directory = vim.api.nvim_call_function("isdirectory", { target_path })

      if not is_directory then
        vim.api.nvim_call_function("mkdir", { target_path, "p", 0700 })
      end

      vim.opt.undodir = target_path
      vim.opt.undofile = true
    end
  end,
}
