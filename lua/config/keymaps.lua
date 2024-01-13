local keymap = vim.keymap.set
local silent = { silent = true }

--  Pracker Maps
keymap("n", "<Leader>q", ":q!<cr>")
keymap("n", "<Leader>w", ":w<cr>")
keymap("n", "<Leader>x", ":x<cr>")
keymap("n", "<Leader>tv", ":botright vnew <Bar> :terminal<cr>")
keymap("n", "<Leader>th", ":botright new <Bar> :terminal<cr>")
-- keymap("n", "<Leader>qq", ":q!<cr>", silent)

-- BOL: Deactivate for new navigation FN + Q  or FN + H -> HOME
-- keymap("n", '<S-left>', '^', silent)

-- EOL: Deactivate for new navigation FN + E  or FN + L -> END
-- keymap("n", '<S-right>', '$', silent)

-- Move Lines
keymap("v", "<A-down>", ":m '>+1<CR>gv=gv", silent)
keymap("v", "<A-up>", ":m '<-2<CR>gv=gv", silent)

-- Move around splits
keymap("n", "<A-left>", "<C-w>h", silent)
keymap("n", "<A-down>", "<C-w>j", silent)
keymap("n", "<A-up>", "<C-w>k", silent)
keymap("n", "<A-right>", "<C-w>l", silent)

-- Split window
keymap("n", "ss", ":split<Return>", silent)
keymap("n", "sv", ":vsplit<Return>", silent)

-- Format piece
keymap("n", "<leader>fd", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
keymap("v", "<leader>fd", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)

-- Go to Definition / References / Code Action
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)

-- Telescope
-- By default <leader><leader>
-- keymap("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
keymap("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
keymap("n", "<leader>fw", "<CMD>lua require('telescope.builtin').grep_string()<CR>")
keymap("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")
keymap("n", "<leader>fn", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

-- Buffers
-- keymap("n", '<Tab>', ':bnext<CR>', silent)
keymap("n", "<S-Tab>", ":bprev<CR>", silent)
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
