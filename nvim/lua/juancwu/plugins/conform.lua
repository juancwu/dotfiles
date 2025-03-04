local formatters_by_ft = {
	lua = { "stylua" },
	javascript = { "prettier", "biome" },
	typescript = { "prettier", "biome" },
	javascriptreact = { "prettier", "biome" },
	typescriptreact = { "prettier", "biome" },
	css = { "prettier", "biome" },
	markdown = { "prettier", "biome" },
	go = { "gofmt" },
	python = { "autopep8" },
	yaml = { "yamlfmt" },
}

-- Function to find the first config file by walking up the directory tree
local function find_first_config()
	local current_dir = vim.fn.expand("%:p:h")
	local home_dir = vim.fn.expand("$HOME")

	local config_files = {
		prettier = { ".prettierrc", ".prettierrc.json", ".prettierrc.js" },
		biome = { "biome.json" },
	}

	while current_dir ~= home_dir and current_dir ~= "/" do
		for formatter, patterns in pairs(config_files) do
			for _, pattern in ipairs(patterns) do
				local config_file = current_dir .. "/" .. pattern
				if vim.fn.filereadable(config_file) == 1 then
					return formatter
				end
			end
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end
	return nil
end

-- Function to determine the formatter based on config files and file type
local function get_formatter()
	local filetype = vim.bo.filetype
	local available_formatters = formatters_by_ft[filetype] or {}
	local formatter = find_first_config()

	if formatter then
		if formatter == "prettier" and vim.tbl_contains(available_formatters, "prettier") then
			vim.g.current_formatter = "prettier"
			return { "prettier" }
		elseif formatter == "biome" and vim.tbl_contains(available_formatters, "biome") then
			vim.g.current_formatter = "biome"
			return { "biome" }
		end
	end

	-- Default to the first available formatter for the file type, or prettier if none specified
	vim.g.current_formatter = available_formatters[1] or "prettier"
	return { vim.g.current_formatter }
end

local function format_on_save(bufnr)
	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
		return
	end
	local formatters = get_formatter()
	return {
		timeout_ms = 500,
		lsp_format = "fallback",
		formatters = formatters,
	}
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufEnter" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>ff",
			function()
				local formatters = get_formatter()
				require("conform").format({ async = true, lsp_format = "fallback", formatters = formatters })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		require("conform").setup({
			notify_on_error = false,
			formatters_by_ft = formatters_by_ft,
			format_on_save = format_on_save,
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

		vim.api.nvim_create_user_command("Formatter", function()
			print("Current formatter: " .. (vim.g.current_formatter or "none"))
		end, {
			desc = "Show current formatter being used",
		})
	end,
}
