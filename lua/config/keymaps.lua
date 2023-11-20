-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- https://www.lazyvim.org/keymaps
local keymap = vim.keymap.set
local silent = {silent = true}

--  Pracker Maps
keymap("n", "<Leader>q", ":q!<cr>")
keymap("n", "<Leader>w", ":w<cr>")
keymap("n", "<Leader>x", ":x<cr>")
keymap("n", "<Leader>tv", ":botright vnew <Bar> :terminal<cr>")
keymap("n", "<Leader>th", ":botright new <Bar> :terminal<cr>")
-- keymap("n", "<Leader>qq", ":q!<cr>", silent)

-- Toggle Tree

keymap("n", "<leader>n", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>",
       silent)

-- EOL & BOL: Deactivate for new navigation Q y E 60% layout
-- keymap("n", '<S-right>', '$', silent)
-- keymap("n", '<S-left>', '^', silent)

-- Move Lines

keymap("n", '<S-down>', ':m .+1<CR>==gi', silent)
keymap("n", '<S-up>', ':m .-2<CR>==gi', silent)

keymap("i", '<S-down>', '<Esc>:m .+1<CR>==gi', silent)
keymap("i", '<S-up>', '<Esc>:m .-2<CR>==gi', silent)

keymap("v", '<S-down>', ":m '>+1<CR>gv=gv", silent)
keymap("v", '<S-up>', ":m ':m .-2<CR>==gi", silent)

-- Move around splits

keymap("n", '<A-left>', '<C-w>h', silent)
keymap("n", '<A-down>', '<C-w>j', silent)
keymap("n", '<A-up>', '<C-w>k', silent)
keymap("n", '<A-right>', '<C-w>l', silent)

-- Split window
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)

-- Format piece

keymap("n", "<leader>fd", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
       silent)
keymap("v", "<leader>fd", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>",
       silent)

-- Go to Definition / References / Code Action

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap("n", "gr",
       "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>",
       silent)
keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)

-- Telescope -> $ brew install ripgrep (engine search should be installed)

keymap("n", "<leader>ff",
       "<CMD>lua require('telescope.builtin').find_files()<CR>")

keymap("n", "<leader>fg",
       "<CMD>lua require('telescope.builtin').live_grep()<CR>")

keymap("n", "<leader>fc",
       "<CMD>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")

keymap("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")

keymap("n", "<leader>fn",
       "<CMD>lua require('telescope.builtin').help_tags()<CR>")

keymap("n", "<leader>fw",
       "<CMD>lua require('telescope.builtin').grep_string()<CR>")

keymap("n", "<Leader>pf",
       "<CMD>lua require('plugins.telescope').project_files({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' })<CR>")

keymap("n", "<Leader>pw",
       "<CMD>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })<CR>")

-- Buffers
keymap("n", '<Tab>', ':bnext<CR>', silent)
keymap("n", '<S-Tab>', ':bprev<CR>', silent)
keymap("n", "gn", ":bn<CR>", silent)
keymap("n", "gp", ":bp<CR>", silent)
keymap("n", "<S-q>", ":BufferClose<CR>", silent)

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap("n", "te", ":tabedit<CR>")
