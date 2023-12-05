return {
    {"nvim-lua/plenary.nvim"}, {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({default = true})
        end
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
    }, {"rcarriga/nvim-notify", opts = {timeout = 2000}}, -- animations
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function(_, opts) opts.scroll = {enable = false} end
    }, {
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
    }, -- add symbols-outline
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = {
            {"<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline"}
        },
        config = true
    }, {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({color_square_width = 2})
        end
    }, -- the opts function can also be used to change the default opts:
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, "😄")
        end,
        opts = {
            options = {
                -- globalstatus = false,
                theme = "solarized_dark"
            }
        }
    }
}