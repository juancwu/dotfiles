return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = {
		"BufReadPost",
		"BufNewFile",
	},
	branch = "master",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"go",
				"gosum",
				"gomod",
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			auto_install = true,
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>c",
					node_incremental = "<C-p>",
					scope_incremental = "<C-s>",
					node_decremental = "<M-p>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>]"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>["] = "@parameter.inner",
					},
				},
			},
			autotag = {
				enable = false,
				enable_close_on_slash = false,
			},
		})
	end,
}
