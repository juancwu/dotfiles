return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	enabled = true,
	-- load plugin for eazy and fast creation of dailies
	keys = {
		{ "<leader>od", "<cmd>ObsidianToday<cr>", desc = "New obsidian daily note" },
	},
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian Vault",
			},
		},
		follow_url_func = function(url)
			vim.fn.jobstart({ "open", url })
		end,
		note_id_func = function(title)
			if title ~= nil then
				print("create new obsidian note with given title: " .. title)
				return title
			end
			local suffix = ""
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
		daily_notes = {
			folder = "dailies",
			date_format = "%d-%m-%Y",
		},
	},
	mappings = {
		["<CR>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
	},
}
