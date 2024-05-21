return {
  { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
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
        -- "astro",
        "bash",
        "cmake",
        "css",
        "fish",
        "gitignore",
        "graphql",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "regex",
        "scss",
        -- "svelte",
        "tsx",
        "typescript",
        "tsx",
        "vim",
        "vue",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "css-lsp",
        "luacheck",
        "selene",
        "shellcheck",
        "stylua",
        "typescript-language-server",
        "vue-language-server",
      },
    },
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
}
