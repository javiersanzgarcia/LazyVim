local keymap = vim.keymap.set
local silent = { silent = true }

--  Pracker Maps
keymap("n", "<leader>qq", ":qa!<CR>", silent)
keymap("n", "<Leader>q", ":q!<CR>", silent)
keymap("n", "<Leader>w", ":w<CR>", silent)
keymap("n", "<Leader>x", ":x<CR>", silent)
keymap("n", "<Leader>tv", ":botright vnew <Bar> :terminal<CR>", silent)
keymap("n", "<Leader>th", ":botright new <Bar> :terminal<CR>", silent)

-- Move around splits
keymap({ "n", "t" }, "<A-left>", "<C-w>h", silent)
keymap({ "n", "t" }, "<A-down>", "<C-w>j", silent)
keymap({ "n", "t" }, "<A-up>", "<C-w>k", silent)
keymap({ "n", "t" }, "<A-right>", "<C-w>l", silent)

-- Split window
keymap("n", "ss", ":split<Return>", silent)
keymap("n", "sv", ":vsplit<Return>", silent)

-- Format piece
keymap("n", "<leader>fd", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
keymap("v", "<leader>fd", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)

-- Buffers
keymap("n", "<S-j>", ":bnext<CR>", silent)
keymap("n", "<S-k>", ":bprev<CR>", silent)
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
