vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = '+1'
vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true -- highlight the current line
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = 'utf-8' -- the encoding written to a file
vim.opt.fillchars.eob = ' '
vim.opt.guifont = 'monospace:h24' -- the font used in graphical neovim applications
vim.opt.history = 100
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.iskeyword:append('-')
vim.opt.laststatus = 3
vim.opt.list = true -- show some invisible characters (tabs...)
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }
vim.opt.mouse = 'a' -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set number column width to 4
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = true -- hide relative numberline
vim.opt.ruler = false
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.shortmess:append('c')
vim.opt.showcmd = false
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and to the right the cursor.
vim.opt.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.textwidth = 100
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.whichwrap:append('<,>,[,],h,l')
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
