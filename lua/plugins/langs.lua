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
	{
		"williamboman/mason.nvim",
	},
	{
		"OlegGulevskyy/better-ts-errors.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = {
			keymaps = {
				toggle = "<leader>dd", -- default '<leader>dd'
				go_to_definition = "<leader>dx", -- default '<leader>dx'
			},
		},
	},
	-- template string support ${}
	{
		"rxtsel/template-string.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("template-string").setup()
		end,
	},
}
