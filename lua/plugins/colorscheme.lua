return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = {italic = true},
                    keywords = {italic = true},
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "dark" -- style for floating windows
                }
            }
        end
    }
}
