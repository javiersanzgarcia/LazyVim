-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    -- add gruvbox
    {"ellisonleao/gruvbox.nvim"}, -- Configure LazyVim to load gruvbox
    {"LazyVim/LazyVim", opts = {colorscheme = "gruvbox"}},

    {"folke/tokyonight.nvim", lazy = true, opts = {style = "moon"}},
    -- Configure Git conflict plugin
    {"akinsho/git-conflict.nvim", version = "*", config = true},
    -- change trouble config
    {
        "folke/trouble.nvim",
        -- opts will be merged with the parent spec
        opts = {use_diagnostic_signs = true}
    }, -- disable trouble
    {"folke/trouble.nvim", enabled = false}, -- add symbols-outline
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = {
            {"<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline"}
        },
        config = true
    }, -- override nvim-cmp and add cmp-emoji
    {
        "hrsh7th/nvim-cmp",
        dependencies = {"hrsh7th/cmp-emoji"},
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(
                               vim.list_extend(opts.sources, {{name = "emoji"}}))
        end
    }, -- change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            -- add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fp",
                function()
                    require("telescope.builtin").find_files({
                        cwd = require("lazy.core.config").options.root
                    })
                end,
                desc = "Find Plugin File"
            }
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {prompt_position = "top"},
                sorting_strategy = "ascending",
                winblend = 0
            }
        }
    }, -- add telescope-fzf-native
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end
        }
    }, -- add pyright to lspconfig
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = {}
            }
        }
    }, -- add tsserver and setup with typescript.nvim instead of lspconfig
    -- lsp servers
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {enabled = true},
            ---@type lspconfig.options
            servers = {
                cssls = {},
                tailwindcss = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(
                                   ...)
                    end
                },
                tsserver = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(
                                   ...)
                    end,
                    single_file_support = false,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "literal",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true
                            }
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true
                            }
                        }
                    }
                },
                html = {},
                yamlls = {settings = {yaml = {keyOrdering = false}}},
                lua_ls = {
                    -- enabled = false,
                    single_file_support = true,
                    settings = {
                        Lua = {
                            workspace = {checkThirdParty = false},
                            completion = {
                                workspaceWord = true,
                                callSnippet = "Both"
                            },
                            misc = {
                                parameters = {
                                    -- "--log-level=trace",
                                }
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable"
                            },
                            doc = {privateName = {"^_"}},
                            type = {castNumberToInteger = true},
                            diagnostics = {
                                disable = {
                                    "incomplete-signature-doc", "trailing-space"
                                },
                                -- enable = false,
                                groupSeverity = {
                                    strong = "Warning",
                                    strict = "Warning"
                                },
                                groupFileStatus = {
                                    ["ambiguity"] = "Opened",
                                    ["await"] = "Opened",
                                    ["codestyle"] = "None",
                                    ["duplicate"] = "Opened",
                                    ["global"] = "Opened",
                                    ["luadoc"] = "Opened",
                                    ["redefined"] = "Opened",
                                    ["strict"] = "Opened",
                                    ["strong"] = "Opened",
                                    ["type-check"] = "Opened",
                                    ["unbalanced"] = "Opened",
                                    ["unused"] = "Opened"
                                },
                                unusedLocalExclude = {"_*"}
                            },
                            format = {
                                enable = false,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "2",
                                    continuation_indent_size = "2"
                                }
                            }
                        }
                    }
                }
            },
            setup = {}
        }
    }, -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "astro", "bash", "cmake", "cpp", "css", "fish", "gitignore",
                "go", "graphql", "html", "http", "java", "javascript", "json",
                "lua", "markdown", "markdown_inline", "query", "regex", "rust",
                "scss", "sql", "svelte", "tsx", "php", "python", "typescript",
                "vim", "yaml"
            }
        }
    },

    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- add tsx and treesitter
            vim.list_extend(opts.ensure_installed, {"tsx", "typescript"})
        end
    }, -- the opts function can also be used to change the default opts:
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, "😄")
        end
    }, -- or you can return new options to override all the defaults
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return { --[[add your custom lualine config here]] }
        end
    }, -- use mini.starter instead of alpha
    {import = "lazyvim.plugins.extras.ui.mini-starter"},

    -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
    {import = "lazyvim.plugins.extras.lang.json"},

    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "css-lsp", "flake8", "luacheck", "selene", "shellcheck",
                "shfmt", "stylua", "tailwindcss-language-server",
                "typescript-language-server"
            }
        }
    }, -- Use <tab> for completion and snippets (supertab)
    -- first: disable default <tab> and <s-tab> behavior in LuaSnip
    {"L3MON4D3/LuaSnip", keys = function() return {} end},
    -- then: setup supertab in cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {"hrsh7th/cmp-emoji"},
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                               col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
            local cmp = require("cmp")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- this way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            })
        end
    }
}
