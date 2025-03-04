local linters_by_ft = {
	javascript = { "biomejs" },
	typescript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescriptreact = { "biomejs" },
	jsonc = { "biomejs" },
	json = { "biomejs" },
	css = { "biomejs" },
}

return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost" },
	keys = {
		{
			"<leader>lf",
			function()
				require("lint").try_lint()
			end,
			mode = "n",
			desc = "[L]int [F]ile",
		},
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = linters_by_ft

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})

		vim.api.nvim_create_user_command("Lint", function()
			lint.try_lint()
		end, { desc = "Lint file" })
	end,
}
