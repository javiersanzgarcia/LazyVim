return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		require("refactoring").setup({
			printf_statements = { java = true, go = true, js = true, ts = true, lua = true },
			print_var_statements = { java = true, go = true, js = true, ts = true, lua = true },
		})
	end,
}
