local opt = vim.opt -- for conciseness

-- Set highlight on search
opt.hlsearch = false
opt.incsearch = true

-- Enable mouse mode
opt.mouse = 'a'

-- Enable break indent
opt.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menu,menuone,noselect'

-- backup
opt.backup = false -- does not create a backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile = false -- does not create a swapfile
opt.undofile = true -- save undo history
opt.undolevels = 10000
opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- save undo history for the entire time

-- command line
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- line numbers
vim.wo.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.wo.numberwidth = 4 -- set number column width to 4
vim.wo.relativenumber = true -- show relative line numbers

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.shiftround = true -- Round indent
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.breakindent = true -- enable break indent

-- line wrapping
opt.wrap = false -- disable line wrapping

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- column line
opt.colorcolumn = '+1'
opt.textwidth = 100

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- appearance
opt.termguicolors = true -- turn on termguicolors for the colorscheme to work
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.ruler = false
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs

-- clipboard
opt.clipboard:append('unnamedplus') -- use system clipboard as default register

-- split windows
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitright = true -- split vertical window to the right

opt.iskeyword:append('-') -- consider string-string as whole word

-- invisible characters
opt.list = true -- show some invisible characters (tabs...)
opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }

-- popup menu
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- pop up menu height

-- scroll lines and columns
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and to the right the cursor.
vim.wo.signcolumn = 'yes'
opt.isfname:append('@-@')

opt.smartindent = true -- make indenting smarter again by inserting indents automatically

-- UX
opt.autowrite = true -- Enable auto write
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.updatetime = 200 -- Decrease update time
opt.timeout = true
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.whichwrap:append('<,>,[,],h,l')

-- editor
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shortmess:append({ W = true, I = true, c = true })
opt.spelllang = { 'en' }
opt.wildmode = 'longest:full,full' -- Command-line completion mode

if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
