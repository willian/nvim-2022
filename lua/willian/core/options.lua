local opt = vim.opt -- for conciseness
--
-- opt.hidden = true -- required to keep multiple buffers and open multiple buffers

-- backup
opt.backup = false -- does not create a backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- command line
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 4 -- set number column width to 4
opt.relativenumber = true -- show relative line numbers

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line
-- column line
opt.colorcolumn = '+1'
opt.textwidth = 100

-- appearance

-- turn on termguicolors for the colorscheme to work
opt.termguicolors = true
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift
opt.ruler = false
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append('unnamedplus') -- use system clipboard as default register

-- split windows
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitright = true -- split vertical window to the right

opt.iskeyword:append('-') -- consider string-string as whole word

-- file encoding
opt.fileencoding = 'utf-8' -- the encoding written to a file

-- invisible characters
opt.list = true -- show some invisible characters (tabs...)
opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }

opt.mouse = 'a' -- allow the mouse to be used in neovim

-- popup menu
opt.pumheight = 10 -- pop up menu height

-- scroll lines and columns
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and to the right the cursor.

opt.smartindent = true -- make indenting smarter again

opt.swapfile = false -- does not create a swapfile

-- UX
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion (4000ms default)
opt.whichwrap:append('<,>,[,],h,l')

-- opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
-- opt.conceallevel = 0 -- so that `` is visible in markdown files
-- opt.fillchars.eob = ' '
-- opt.history = 100
-- opt.laststatus = 3
-- opt.shortmess:append('c')
-- opt.showcmd = false
-- opt.hidden = true -- required to keep multiple buffers and open multiple buffers
