return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "go" },
			},
		},
	},
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
	cmd = { "GoDoc" }, -- optional
	opts = {
		picker = {
			type = "telescope",
		},
	},
}
