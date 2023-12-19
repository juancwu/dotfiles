return {
	-- lspconfig
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required

			-- Neovim Plugin Development Completions
			{
				"folke/neodev.nvim",
				opts = {},
			},

			-- formatting
			{
				"stevearc/conform.nvim",
				opts = {
					formatters_by_ft = {
						lua = { "stylua" },
					},
					format_on_save = {
						timeout_ms = 500,
						lsp_fallback = true,
					},
				},
			},
		},
		config = function()
			-- required to setup neodev before lspconfig
			require("neodev").setup({})

			local lspzero = require("lsp-zero")

			lspzero.preset({})

			lspzero.on_attach(function(client, bufnr)
				lspzero.default_keymaps({
					buffer = bufnr,
					omit = {
						"gr",
					},
				})

				function nmap(key, action, desc)
					vim.keymap.set("n", key, action, {
						desc = "LSP: " .. desc,
					})
				end

				nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto Prev Diagnostic")
				nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto Next Diagnostic")

				local current_dir = vim.fn.expand("%:p:h")

				-- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })

				-- format with space + f
				-- vim.keymap.set("n", "<leader>fb", "<cmd>lua vim.lsp.buf.format()<CR>",
				--     { desc = "[F]ormat [B]uffer" })
				nmap("<leader>fb", "<cmd>lua vim.lsp.buf.format()<CR>", "[F]ormat [B]uffer")

				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					require("conform").format({ bufnr = bufnr })
				end, { desc = "Format current buffer with LSP" })
			end)

			lspzero.ensure_installed({
				"tsserver",
				"eslint",
				"tailwindcss",
			})

			-- lspzero.format_on_save({
			--     format_ops = {
			--         async = true,
			--         timeout_ms = 10000,
			--     },
			--     servers = {
			--         ["lua_ls"] = { "lua" },
			--         ["null-ls"] = {
			--             "javascript",
			--             "typescript",
			--             "javascriptreact",
			--             "typescriptreact",
			--             "html",
			--             "css",
			--         },
			--     },
			-- })

			local status, lspconfig = pcall(require, "lspconfig")

			if status then
				lspconfig.tsserver.setup({})
				lspconfig.tailwindcss.setup({
					filetypes = {
						"templ",
						"html",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
					},
					init_options = {
						userLanguages = {
							templ = "html",
						},
					},
				})
				lspconfig.zls.setup({})
				lspconfig.rust_analyzer.setup({})
				lspconfig.gopls.setup({})
				lspconfig.html.setup({})
				vim.filetype.add({
					extension = {
						templ = "templ",
					},
				})
				lspconfig.templ.setup({
					filetypes = {
						"templ",
					},
				})
			end

			lspzero.setup()

			local cmp
			status, cmp = pcall(require, "cmp")

			if not status then
				return
			end

			cmp.setup({
				mapping = {
					-- press 'enter' to confirm completion/suggestion
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
				},
			})
		end,
	},
}
