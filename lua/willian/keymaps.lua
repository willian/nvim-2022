-- NOTE: Function got from LazyVim:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local function map(mode, lhs, rhs, opts)
  local keys = require('lazy.core.handler').handlers.keys

  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- -- Move to window using the <ctrl> hjkl keys
-- map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
-- map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
-- map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
-- map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- delete single character without copying into register
map('n', 'x', '"_x')

-- increment/decrement numbers
map('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
map('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- window management
map('n', '<leader>sv', '<C-w>v', { desc = 'split window vertically' })
map('n', '<leader>sh', '<C-w>s', { desc = 'split window horizontally' })
map('n', '<leader>se', '<C-w>=', { desc = 'make split windows equal width & height' })
map('n', '<leader>sq', ':close<CR>', { desc = 'close current split window' })

-- buffers navigation
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- select all
map('n', '<C-a>', 'gg<S-v>G')

-- Appends lines but keeps the cursor position
map('n', 'J', 'mzJ`z')

-- Keeps cursor at the middle of the screen when jupping top and bottom
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Keeps cursor at the middle while searching
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map(
  'n',
  '<leader>sr',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = 'Find/replace cursor word in the document' }
)

map('n', '<leader>d', '"_d')

map('n', '<leader>f', vim.lsp.buf.format, { desc = 'LSP Format' })

-- Searching
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- use jk to exit insert mode
map('i', 'jk', '<ESC>')

-- Visual --

-- better paste
map('v', 'p', '"_dP')

-- move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up' })

map('v', '<leader>d', '"_d')

-- stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- lazy
map('n', '<leader>L', '<cmd>:Lazy<cr>', { desc = 'Lazy' })

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- highlights under cursor
if vim.fn.has('nvim-0.9.0') == 1 then
  map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
end

-- windows
map('n', '<leader>ww', '<C-W>p', { desc = 'Other window' })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete window' })
map('n', '<leader>w-', '<C-W>s', { desc = 'Split window below' })
map('n', '<leader>w|', '<C-W>v', { desc = 'Split window right' })
map('n', '<leader>-', '<C-W>s', { desc = 'Split window below' })
map('n', '<leader>|', '<C-W>v', { desc = 'Split window right' })

map('c', 'Q', 'q')
map('c', 'W', 'w')
map('c', 'WA', 'wa')
map('c', 'WQ', 'wq')
map('c', 'wQ', 'wq')
map('c', 'WQA', 'wqa')
map('c', 'Wqa', 'wqa')
map('c', 'wQA', 'wqa')
map('c', 'WQa', 'wqa')
map('c', 'Wa', 'wa')
map('c', 'Wq', 'wq')
map('c', 'X', 'x')
