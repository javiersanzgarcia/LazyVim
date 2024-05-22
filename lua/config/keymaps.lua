local keymap = vim.keymap.set
local silent = { silent = true }

--  Pracker Maps
keymap("n", "<leader>qq", ":qa!<CR>", silent)
keymap("n", "<Leader>q", ":q!<CR>", silent)
keymap("n", "<Leader>w", ":w<CR>", silent)
keymap("n", "<Leader>x", ":x<CR>", silent)
keymap("n", "<Leader>tv", ":botright vnew <Bar> :terminal<CR>", {
  desc = "Open Vertical Terminal",
})
keymap("n", "<Leader>th", ":botright new <Bar> :terminal<CR>", {
  desc = "Open Horizontal Terminal",
})

-- Move around splits
keymap({ "n", "t" }, "<A-left>", "<C-w>h", silent)
keymap({ "n", "t" }, "<A-down>", "<C-w>j", silent)
keymap({ "n", "t" }, "<A-up>", "<C-w>k", silent)
keymap({ "n", "t" }, "<A-right>", "<C-w>l", silent)

-- Split window
keymap("n", "ss", ":split<Return>", silent)
keymap("n", "sv", ":vsplit<Return>", silent)

-- Buffers
keymap("n", "<S-Tab>", ":bn<CR>", silent)

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Zen Mode
keymap("n", "<leader>z", "<cmd>ZenMode<cr>", silent)

-- Go to Definition / References / Code Action
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)

-- Some Telescope additional keymaps
keymap("n", "<leader>sf", "<CMD>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", {
  desc = "Grep in open files",
})
keymap("n", "<leader>sp", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {
  desc = "Grep with params",
})

-- Delete other buffers
keymap(
  "n",
  "<leader>bo",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but keep the current one" }
)

-- REMINDER: This is a custom keymap for the plugin `better TS Errors`

-- toggle = "<leader>dd", -- default '<leader>dd'
-- go_to_definition = "<leader>dx", -- default '<leader>dx'
