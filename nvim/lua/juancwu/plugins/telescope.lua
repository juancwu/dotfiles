local function get_fd_command()
	if vim.fn.executable("fd") == 1 then
		return "fd"
	elseif vim.fn.executable("fdfind") == 1 then
		return "fdfind"
	end
	return nil
end

return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			enabled = true,
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"nvim-lua/plenary.nvim",
			},
			enabled = true,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local fb_actions = require("telescope").extensions.file_browser.actions

		local function telescope_buffer_dir()
			return vim.fn.expand("%:p:h")
		end

		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				file_browser = {
					theme = "dropdown",
					hijack_netrw = false,
					hidden = true,
					mappings = {
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
							["<C-j>"] = function(bufnr)
								actions.move_selection_next(bufnr)
							end,
							["<C-k>"] = function(bufnr)
								actions.move_selection_previous(bufnr)
							end,
							["<C-s>"] = function(bufnr)
								actions.select_vertical(bufnr)
							end,
						},
						["n"] = {
							["a"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["d"] = fb_actions.remove,
							["e"] = fb_actions.change_cwd,
							["<C-s>"] = function(bufnr)
								actions.select_vertical(bufnr)
							end,
							["<C-a>"] = function(bufnr)
								actions.toggle_all(bufnr)
							end,
							["<C-d>"] = function(bufnr)
								actions.move_selection_next(bufnr)
							end,
							["<C-u>"] = function(bufnr)
								actions.move_selection_previous(bufnr)
							end,
						},
					},
				},
			},
		})

		pcall(telescope.load_extension, "file_browser")
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		-- Builtin pickers
		vim.keymap.set("n", "<leader>sf", function()
			local fd_cmd = get_fd_command()
			local config = {
				hidden = true,
				file_ignore_patterns = {
					"node%_modules/.*",
					"%.git/.*",
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
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]o to [R]eferences", noremap = true })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[G]o to [D]efinitions" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })

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
	end,
}
