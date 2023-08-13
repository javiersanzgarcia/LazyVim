return {
    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            transparent = true, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value `:help attr-list`
                comments = "italic",
                keywords = "italic",
                functions = "NONE",
                variables = "NONE",
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "transparent", -- style for sidebars, see below
                floats = "transparent" -- style for floating windows
            },
            sidebars = {"qf", "help"}, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false, -- dims inactive windows
            lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            on_colors = function(colors) colors.border = "#1A1B26" end,
            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            -- on_highlights = function(highlights, colors) end,
            on_highlights = function(hl, c)
                local prompt = "#FFA630"
                local text = "#488dff"
                local none = "NONE"

                hl.TelescopeTitle = {fg = prompt}
                hl.TelescopeNormal = {bg = none, fg = none}
                hl.TelescopeBorder = {bg = none, fg = text}
                hl.TelescopeMatching = {fg = prompt}
                hl.MsgArea = {fg = c.fg_dark}
            end
        }
    }, {"nvim-lua/plenary.nvim"}, {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({default = true})
        end
    }, {
        'echasnovski/mini.map',
        version = false,
        lazy = false,
        config = function()
            local map = require('mini.map')
            require('mini.map').setup({
                -- Highlight integrations (none by default)
                integrations = nil,
                -- Symbols used to display data
                symbols = {
                    -- Encode symbols. See`:h MiniMap.config`for specification and
                    -- `:h MiniMap.gen_encode_symbols`for pre-built ones.
                    -- Default: solid blocks with 3x2 resolution.
                    encode = map.gen_encode_symbols.block('2x1'),
                    -- Scrollbar parts for view and line. Use empty string to disable any.
                    scroll_line = '█',
                    scroll_view = '┃'
                },
                -- Window options
                window = {
                    -- Whether window is focusable in normal way (with `wincmd`or mouse)
                    focusable = false,
                    -- Side to stick ('left' or 'right')
                    side = 'right',
                    -- Whether to show count of multiple integration highlights
                    show_integration_count = true,
                    -- Total width
                    width = 10,
                    -- Value of 'winblend' option
                    winblend = 25
                }
            })
        end
    }, {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    }, {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip"
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText",
                                {link = "Comment", default = true})
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            return {
                completion = {completeopt = "menu,menuone,noinsert"},
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Insert
                    }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Insert
                    }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"},
                    {name = "path"}
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("lazyvim.config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end
                },
                experimental = {ghost_text = {hl_group = "CmpGhostText"}},
                sorting = defaults.sorting
            }
        end
    }, {
        "neovim/nvim-lspconfig",
        dependencies = {"mfussenegger/nvim-jdtls"},
        opts = {
            setup = {
                jdtls = function(_, opts)
                    vim.api.nvim_create_autocmd("FileType", {
                        pattern = "java",
                        callback = function()
                            require("lazyvim.util").on_attach(
                                function(_, buffer)
                                    vim.keymap.set("n", "<leader>di",
                                                   "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Organize Imports"
                                    })
                                    vim.keymap.set("n", "<leader>dt",
                                                   "<Cmd>lua require'jdtls'.test_class()<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Test Class"
                                    })
                                    vim.keymap.set("n", "<leader>dn",
                                                   "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Test Nearest Method"
                                    })
                                    vim.keymap.set("v", "<leader>de",
                                                   "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Extract Variable"
                                    })
                                    vim.keymap.set("n", "<leader>de",
                                                   "<Cmd>lua require('jdtls').extract_variable()<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Extract Variable"
                                    })
                                    vim.keymap.set("v", "<leader>dm",
                                                   "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Extract Method"
                                    })
                                    vim.keymap.set("n", "<leader>cf",
                                                   "<cmd>lua vim.lsp.buf.formatting()<CR>",
                                                   {
                                        buffer = buffer,
                                        desc = "Format"
                                    })
                                end)

                            local project_name =
                                vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                            -- vim.lsp.set_log_level('DEBUG')
                            local workspace_dir =
                                "/home/jake/.workspace/" .. project_name -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
                            local config = {
                                -- The command that starts the language server
                                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                                cmd = {

                                    "java", -- or '/path/to/java17_or_newer/bin/java'
                                    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

                                    "-javaagent:/home/jake/.local/share/java/lombok.jar",
                                    -- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
                                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                                    "-Dosgi.bundles.defaultStartLevel=4",
                                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                                    "-Dlog.protocol=true", "-Dlog.level=ALL",
                                    -- '-noverify',
                                    "-Xms1g", "--add-modules=ALL-SYSTEM",
                                    "--add-opens",
                                    "java.base/java.util=ALL-UNNAMED",
                                    "--add-opens",
                                    "java.base/java.lang=ALL-UNNAMED", "-jar",
                                    vim.fn
                                        .glob(
                                        "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
                                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                                    -- Must point to the                                                     Change this to
                                    -- eclipse.jdt.ls installation                                           the actual version

                                    "-configuration",
                                    "/usr/share/java/jdtls/config_linux",
                                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                                    -- eclipse.jdt.ls installation            Depending on your system.

                                    -- See `data directory configuration` section in the README
                                    "-data", workspace_dir
                                },

                                -- This is the default if not provided, you can remove it. Or adjust as needed.
                                -- One dedicated LSP server & client will be started per unique root_dir
                                root_dir = require("jdtls.setup").find_root({
                                    ".git", "mvnw", "gradlew"
                                }),

                                -- Here you can configure eclipse.jdt.ls specific settings
                                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                                -- for a list of options
                                settings = {java = {}},
                                handlers = {
                                    ["language/status"] = function(_, result)
                                        -- print(result)
                                    end,
                                    ["$/progress"] = function(_, result, ctx)
                                        -- disable progress updates.
                                    end
                                }
                            }
                            require("jdtls").start_or_attach(config)
                        end
                    })
                    return true
                end
            }
        }
    }

}
