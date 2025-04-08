local linters_by_ft = {
	javascript = { "biomejs", "eslint" },
	typescript = { "biomejs", "eslint" },
	javascriptreact = { "biomejs", "eslint" },
	typescriptreact = { "biomejs", "eslint" },
	jsonc = { "biomejs" },
	json = { "biomejs" },
	css = { "biomejs" },
}

-- Function to find the first config file by walking up the directory tree
local function find_first_config()
	local current_dir = vim.fn.expand("%:p:h")
	local home_dir = vim.fn.expand("$HOME")

	local config_files = {
		biomejs = { "biome.json" },
		eslint = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml" },
	}

	while current_dir ~= home_dir and current_dir ~= "/" do
		for linter, patterns in pairs(config_files) do
			for _, pattern in ipairs(patterns) do
				local config_file = current_dir .. "/" .. pattern
				if vim.fn.filereadable(config_file) == 1 then
					return linter
				end
			end
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end
	return nil
end

-- Function to determine the linter based on config files and file type
local function get_linter()
	local filetype = vim.bo.filetype
	local available_linters = linters_by_ft[filetype] or {}
	local linter = find_first_config()

	if linter then
		if vim.tbl_contains(available_linters, linter) then
			vim.g.current_linter = linter
			return linter
		end
	end

	return nil
end

local function lint()
	local nvimlint = require("lint")
	local linter = get_linter()
	if linter ~= nil then
		nvimlint.try_lint(linter)
	else
		print("No linter found for filetype: " .. vim.bo.filetype)
	end
end

return {
	"mfussenegger/nvim-lint",
	keys = {
		{
			"<leader>lf",
			function()
				lint()
			end,
			mode = "n",
			desc = "[L]int [F]ile",
		},
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint()
			end,
		})

		vim.api.nvim_create_user_command("Lint", function()
			lint()
		end, { desc = "Lint file" })

		vim.api.nvim_create_user_command("LintInfo", function()
			print("Current linter: " .. (vim.g.current_linter or "none"))
		end, {
			desc = "Show current linter being used",
		})
	end,
}
