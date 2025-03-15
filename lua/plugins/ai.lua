return {
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	build = ":Codeium Auth",
	-- 	config = function()
	-- 		vim.keymap.set("i", "<C-g>", function()
	-- 			return vim.fn["codeium#Accept"]()
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<C-l>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<C-M>", function()
	-- 			return vim.fn["codeium#Complete"]()
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<C-x>", function()
	-- 			return vim.fn["codeium#Clear"]()
	-- 		end, { expr = true })
	-- 	end,
	-- },

	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-g>",
					clear_suggestion = "<C-x>",
					accept_word = "<C-j>",
				},
			})
		end,
	},
}
