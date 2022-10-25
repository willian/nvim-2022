local keymap = vim.keymap.set -- for conciseness
local opts = { silent = true } -- silent keymap option

-- set leader key to space
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

---------------------
-- General Keymaps
---------------------

-- Normal --

-- clear search highlights
keymap('n', '<leader>nh', ':nohl<CR>')

-- delete single character without copying into register
keymap('n', 'x', '"_x')

-- increment/decrement numbers
keymap('n', '<leader>+', '<C-a>', opts) -- increment
keymap('n', '<leader>-', '<C-x>', opts) -- decrement

-- window management
keymap('n', '<leader>sv', '<C-w>v', opts) -- split window vertically
keymap('n', '<leader>sh', '<C-w>s', opts) -- split window horizontally
keymap('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
keymap('n', '<leader>sq', ':close<CR>', opts) -- close current split window

keymap('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
keymap('n', '<leader>tq', ':tabclose<CR>', opts) -- close current tab
keymap('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
keymap('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- buffers navigation
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- clear highlights
keymap('n', '<leader>h', '<CMD>nohlsearch<CR>', opts)

-- select all
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- better paste
keymap('v', 'p', '"_dP', opts)

-- Insert --

-- use jk to exit insert mode
keymap('i', 'jk', '<ESC>', opts)

-- Visual --

-- stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap(
  'v',
  '/',
  "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
  opts
)

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

----------------------
-- Plugin Keybinds
----------------------

-- packer
keymap('n', '<leader>pc', '<CMD>PackerCompile<CR>', opts)
keymap('n', '<leader>pi', '<CMD>PackerInstall<CR>', opts)
keymap('n', '<leader>ps', '<CMD>PackerSync<CR>', opts)
keymap('n', '<leader>pS', '<CMD>PackerStatus<CR>', opts)
keymap('n', '<leader>pu', '<CMD>PackerUpdate<CR>', opts)

-- vim-maximizer
keymap('n', '<leader>sm', ':MaximizerToggle<CR>', opts) -- toggle split window maximization

-- nvim-tree
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts) -- toggle file explorer

-- telescope
keymap('n', '<C-p>', '<CMD>Telescope find_files<CR>', opts) -- find files within current working directory, respects .gitignore
keymap('n', '<leader>ff', '<CMD>Telescope find_files<CR>', opts) -- find files within current working directory, respects .gitignore
keymap('n', '<leader>fs', '<CMD>Telescope live_grep<CR>', opts) -- find string in current working directory as you type
keymap('n', '<leader>ft', '<CMD>Telescope live_grep<CR>', opts) -- find string in current working directory as you type
keymap('n', '<leader>fc', '<CMD>Telescope grep_string<CR>', opts) -- find string under cursor in current working directory
keymap('n', '<leader>fb', '<CMD>Telescope buffers<CR>', opts) -- list open buffers in current neovim instance
keymap('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', opts) -- list available help tags
keymap('n', '<leader>fp', '<CMD>Telescope projects<CR>', opts) -- list recent projects
keymap('n', '<leader>fc', '<CMD>Telescope colorscheme<CR>', opts) -- list colorschemes

-- telescope git commands
keymap('n', '<leader>gc', '<CMD>Telescope git_commits<CR>') -- list all git commits (use <CR> to checkout) ['gc' for git commits]
keymap('n', '<leader>gfc', '<CMD>Telescope git_bcommits<CR>') -- list git commits for current file/buffer (use <CR> to checkout) ['gfc' for git file commits]
keymap('n', '<leader>gb', '<CMD>Telescope git_branches<CR>') -- list git branches (use <CR> to checkout) ['gb' for git branch]
keymap('n', '<leader>gs', '<CMD>Telescope git_status<CR>') -- list current changes per file with diff preview ['gs' for git status]

-- restart lsp server
keymap('n', '<leader>rs', ':LspRestart<CR>') -- mapping to restart lsp if necessary

-- Close buffers
keymap('n', '<S-q>', '<CMD>Bdelete!<CR>', opts)

-- toggleterm
-- keymap('n', [[<C-\>]], '<CMD>ToggleTerm<CR>', opts)
keymap('n', '<leader>t1', '<CMD>1ToggleTerm<CR>', opts)
keymap('n', '<leader>t2', '<CMD>2ToggleTerm<CR>', opts)
keymap('n', '<leader>t3', '<CMD>3ToggleTerm<CR>', opts)
keymap('n', '<leader>t4', '<CMD>4ToggleTerm<CR>', opts)

-- lazygit
keymap('n', '<leader>gg', '<CMD>lua _LAZYGIT_TOGGLE()<CR>', opts)
