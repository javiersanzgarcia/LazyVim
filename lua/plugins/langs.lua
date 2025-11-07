return {

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	-- change trouble config
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"cmake",
				"css",
				"fish",
				"gitignore",
				"graphql",
				"http",
			},
		},
	},
}
