return {
	"folke/snacks.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {

		picker = {
			layout = {
				reverse = true,
				layout = {
					position = "bottom",
					box = "horizontal",
					width = 0.9,
					height = 0.5,
					border = "none",
					{
						box = "vertical",
						{
							win = "list",
							title = " Results ",
							title_pos = "center",
							border = "rounded",
						},
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
					},
					{
						win = "preview",
						title = "{preview:Preview}",
						width = 0.65,
						border = "rounded",
						title_pos = "center",
					},
				},
			},
		},
	},
}
