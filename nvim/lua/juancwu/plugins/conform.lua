return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		require("conform").setup({
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				go = { "gopls" },
				python = { "autopep8" },
				yaml = { "yamlfmt" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		vim.api.nvim_create_user_command("FormatDisable", function()
			vim.g.disable_autoformat = true
		end, {
			desc = "Disable autoformat on save",
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.g.disable_autoformat = false
		end, {
			desc = "Enable autoformat on save",
		})
	end,
}
