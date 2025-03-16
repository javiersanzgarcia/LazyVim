return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
	end,
}
