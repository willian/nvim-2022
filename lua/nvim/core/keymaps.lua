-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-l>', ':bnext<CR>', opts)

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- Tabs
keymap('n', 'te', ':tabedit<CR>', opts) -- Open current directory
keymap('n', '<S-Tab>', ':tabprev<CR>', opts)
keymap('n', '<Tab>', ':tabnext<CR>', opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Command --
keymap('c', 'Q', 'q', opts)
keymap('c', 'W', 'w', opts)
keymap('c', 'WA', 'wa', opts)
keymap('c', 'WQ', 'wq', opts)
keymap('c', 'wQ', 'wq', opts)
keymap('c', 'WQA', 'wqa', opts)
keymap('c', 'Wqa', 'wqa', opts)
keymap('c', 'wQA', 'wqa', opts)
keymap('c', 'WQa', 'wqa', opts)
keymap('c', 'Wa', 'wa', opts)
keymap('c', 'Wq', 'wq', opts)
keymap('c', 'X', 'x', opts)

-- Plugins

-- NvimTree
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts)
keymap('n', '<D-S-b>', ':NvimTreeToggle<CR>', opts)
keymap('n', '<C-S-e>', ':NvimTreeFocus<CR>', opts)

-- Telescope
keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>ft', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fp', ':Telescope projects<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- Close buffers
keymap('n', '<S-q>', '<cmd>Bdelete!<CR>', opts)

-- Git
keymap('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)

-- DAP
keymap('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>", opts)
keymap('n', '<leader>di', "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap('n', '<leader>do', "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap('n', '<leader>dO', "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap('n', '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap('n', '<leader>du', "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap('n', '<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", opts)
