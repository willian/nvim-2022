local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- set leader key to space
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- add list of plugins to install
require('lazy').setup({
  -- lua functions that many plugins use
  { 'nvim-lua/plenary.nvim' },

  -- preferred colorscheme
  { 'folke/tokyonight.nvim' },
  { 'bluz71/vim-nightfly-guicolors' },

  -- maximizes and restores current window
  { 'szw/vim-maximizer' },

  -- essential plugins
  { 'tpope/vim-surround' }, -- add, delete, change surroundings (it's awesome)
  { 'vim-scripts/ReplaceWithRegister' }, -- replace with register contents using motion (gr + motion)
  { 'moll/vim-bbye' }, -- closes buffers in a better way
  { 'lukas-reineke/indent-blankline.nvim' }, -- adds indentation guides to all lines
  { 'akinsho/bufferline.nvim', version = 'v3.*' }, -- better tabs using buffers
  { 'NvChad/nvim-colorizer.lua' }, -- color highlighter
  { 'RRethy/vim-illuminate' }, -- highlighs other uses of the word under the cursor
  { 'ggandor/leap.nvim' }, -- better motion with "s" keybinding
  { 'rcarriga/nvim-notify' }, -- better notifications
  { 'nacro90/numb.nvim' }, -- peeks lines of the buffer in non-obtrusive way
  { 'folke/todo-comments.nvim' }, -- highlight and search for todo comments like TODO, HACK, BUG
  { 'folke/which-key.nvim' }, -- displays a popup with possible key bindings
  { 'xiyaowong/nvim-transparent' }, -- make Neovim transparent

  -- commenting with gc
  { 'numToStr/Comment.nvim' },

  -- file explorer
  { 'nvim-tree/nvim-tree.lua' },

  -- vs-code like icons
  { 'kyazdani42/nvim-web-devicons' },

  -- startup dashboard
  { 'goolord/alpha-nvim' },

  -- statusline
  { 'nvim-lualine/lualine.nvim' },

  -- fuzzy finding w/ telescope
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- dependency for better sorting performance
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }, -- fuzzy finder
  { 'ahmedkhalf/project.nvim' },

  -- autocompletion
  { 'hrsh7th/nvim-cmp' }, -- completion plugin
  { 'hrsh7th/cmp-buffer' }, -- source for text in buffer
  { 'hrsh7th/cmp-path' }, -- source for file system paths
  {
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      vim.defer_fn(function()
        require('willian.plugins.copilot')
      end, 100)
    end,
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup({})
        end,
      },
    },
  },

  -- snippets
  { 'L3MON4D3/LuaSnip' }, -- snippet engine
  { 'saadparwaiz1/cmp_luasnip' }, -- for autocompletion
  { 'rafamadriz/friendly-snippets' }, -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  { 'williamboman/mason.nvim' }, -- in charge of managing lsp servers, linters & formatters
  { 'williamboman/mason-lspconfig.nvim' }, -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  { 'neovim/nvim-lspconfig' }, -- easily configure language servers
  { 'hrsh7th/cmp-nvim-lsp' }, -- for autocompletion
  { 'glepnir/lspsaga.nvim', event = 'BufRead' }, -- enhanced lsp uis
  { 'jose-elias-alvarez/typescript.nvim' }, -- additional functionality for typescript server (e.g. rename file & update imports)
  { 'onsails/lspkind.nvim' }, -- vs-code like icons for autocompletion
  { 'j-hui/fidget.nvim' }, -- UI for nvim-lsp progress
  { 'MunifTanjim/prettier.nvim' }, -- prettier plugin

  -- formatting & linting
  { 'jose-elias-alvarez/null-ls.nvim' }, -- configure formatters & linters
  { 'jayp0521/mason-null-ls.nvim' }, -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'windwp/nvim-ts-autotag',
    },
  },

  -- auto closing
  { 'windwp/nvim-autopairs' }, -- autoclose parens, brackets, quotes, etc...

  -- git integration
  { 'lewis6991/gitsigns.nvim' }, -- show line modifications on left hand side
  { 'f-person/git-blame.nvim' }, -- show git blame info

  -- persist and toggle multiple terminals during an editing session
  { 'akinsho/toggleterm.nvim' },
})
