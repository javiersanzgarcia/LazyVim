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

-- Buffers
keymap("n", "gn", ":bn<CR>", silent)
keymap("n", "gp", ":bp<CR>", silent)

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- REMINDER: This is a custom keymap for the plugin `better TS Errors`

-- toggle = "<leader>dd", -- default '<leader>dd'
-- go_to_definition = "<leader>dx", -- default '<leader>dx'
