return {
    {"nvim-lua/plenary.nvim"}, {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({default = true})
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
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({
                        toggle = true,
                        dir = require("lazyvim.util").get_root()
                    })
                end,
                desc = "Explorer NeoTree (root dir)"
            }, {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute({
                        toggle = true,
                        dir = vim.loop.cwd()
                    })
                end,
                desc = "Explorer NeoTree (cwd)"
            },
            {
                "<leader>e",
                "<leader>fe",
                desc = "Explorer NeoTree (root dir)",
                remap = true
            },
            {
                "<leader>E",
                "<leader>fE",
                desc = "Explorer NeoTree (cwd)",
                remap = true
            }
        },
        deactivate = function() vim.cmd([[Neotree close]]) end,
        init = function()
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = {
                "filesystem", "buffers", "git_status", "document_symbols"
            },
            open_files_do_not_replace_types = {
                "terminal", "Trouble", "qf", "Outline"
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = {enabled = true},
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                    hide_dotfiles = false,
                    hide_gitignored = true
                }
            },
            window = {position = "right", mappings = {["<space>"] = "none"}},
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander"
                }
            }
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end
            })
        end
    }, {
        "akinsho/git-conflict.nvim",
        opts = {
            default_mappings = true, -- disable buffer local mapping created by this plugin
            default_commands = true, -- disable commands created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen', -- command or function to open the conflicts list
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText'
            }
        }
    }, -- messages, cmdline and the popupmenu
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            table.insert(opts.routes, {
                filter = {event = "notify", find = "No information available"},
                opts = {skip = true}
            })
            local focused = true
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = function() focused = true end
            })
            vim.api.nvim_create_autocmd("FocusLost", {
                callback = function() focused = false end
            })
            table.insert(opts.routes, 1, {
                filter = {cond = function() return not focused end},
                view = "notify_send",
                opts = {stop = false}
            })

            opts.commands = {
                all = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = {enter = true, format = "details"},
                    filter = {}
                }
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(event)
                    vim.schedule(function()
                        require("noice.text.markdown").keys(event.buf)
                    end)
                end
            })

            opts.presets.lsp_doc_border = true
        end
    }, {"rcarriga/nvim-notify", opts = {timeout = 5000}}, -- animations
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function(_, opts) opts.scroll = {enable = false} end
    }, -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                -- globalstatus = false,
                theme = "solarized_dark"
            }
        }
    }, -- filename
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
                kitty = {enabled = false, font = "+2"}
            }
        },
        keys = {{"<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode"}}
    }, {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function(_, opts)
            local logo = [[
██████╗ ██████╗  █████╗  ██████╗██╗  ██╗███████╗██████╗ 
██╔══██╗██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██████╔╝██████╔╝███████║██║     █████╔╝ █████╗  ██████╔╝
██╔═══╝ ██╔══██╗██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██║     ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
      ]]

            logo = string.rep("\n", 8) .. logo .. "\n\n"
            opts.config.header = vim.split(logo, "\n")
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
                    side = 'left',
                    -- Whether to show count of multiple integration highlights
                    show_integration_count = true,
                    -- Total width
                    width = 10,
                    -- Value of 'winblend' option
                    winblend = 25
                }
            })
        end
    }

}
