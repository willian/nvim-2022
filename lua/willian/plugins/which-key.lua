local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = 'rounded', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'center', -- align columns left, center or right
  },
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = 'auto', -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = 'v', -- VISUAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
-- see https://neovim.io/doc/user/map.html#:map-cmd
local vmappings = {
  ['/'] = {
    "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
    'Comment',
  },
}
local mappings = {
  [';'] = { '<cmd>Alpha<CR>', 'Dashboard' },
  ['w'] = { '<cmd>w!<CR>', 'Save' },
  ['q'] = { '<cmd>qa<CR>', 'Quit' },
  ['/'] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", 'Comment' },
  ['h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
  -- ['\\'] = { '<cmd>ToggleTerm<CR>', 'Toggle terminal' },
  b = {
    name = 'Buffers',
    b = { '<cmd>BufferLineCyclePrev<cr>', 'Previous' },
    c = { '<cmd>BufferLinePickClose<cr>', 'Pick which buffer to close' },
    f = { '<cmd>Telescope buffers<cr>', 'Find' },
    j = { '<cmd>BufferLinePick<cr>', 'Jump' },
    D = { '<cmd>BufferLineSortByDirectory<cr>', 'Sort by directory' },
    L = { '<cmd>BufferLineSortByExtension<cr>', 'Sort by language' },
  },
  p = {
    name = 'Packer',
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    s = { '<cmd>PackerSync<cr>', 'Sync' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
    S = { '<cmd>PackerStatus<cr>', 'Status' },
  },

  l = {
    name = 'LSP',
    a = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
    d = { '<cmd>Lspsaga show_cursor_diagnostics<cr>', 'Diagnostics' },
    e = { '<cmd>Telescope quickfix<cr>', 'Telescope Quickfix' },
    f = {
      '<cmd>lua vim.lsp.buf.format({ async = true, filter = function(client) return client.name == "null-ls" end })<cr>',
      'Format',
    },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    l = { vim.lsp.codelens.run, 'CodeLens Action' },
    q = { vim.diagnostic.setloclist, 'Quickfix' },
    r = { '<cmd>Lspsaga rename', 'Rename' },
    w = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
    D = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Diagnostics' },
    M = { '<cmd>Mason<cr>', 'Installer Info' },
  },
  f = {
    name = 'Search',
    b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
    f = { '<cmd>Telescope find_files<cr>', 'Find File' },
    h = { '<cmd>Telescope help_tags<cr>', 'Help tags' },
    p = { '<CMD>Telescope projects<CR>', 'Projects' },
    s = { '<cmd>Telescope live_grep<cr>', 'Text' },
    t = { '<cmd>Telescope live_grep<cr>', 'Text' },
    P = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      'Colorscheme with Preview',
    },
  },
  T = {
    name = 'Treesitter',
    i = { ':TSConfigInfo<cr>', 'Info' },
    u = { ':TSUpdate<cr>', 'Update' },
  },
  t = {
    name = 'Terminal',
    ['1'] = { ':1ToggleTerm<cr>', '1' },
    ['2'] = { ':2ToggleTerm<cr>', '2' },
    ['3'] = { ':3ToggleTerm<cr>', '3' },
    ['4'] = { ':4ToggleTerm<cr>', '4' },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
