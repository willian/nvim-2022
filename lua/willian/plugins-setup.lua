---@diagnostic disable: missing-parameter
local fn = vim.fn

-- auto install packer if not installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- autocommand that reloads neovim and installs/updates/removes plugins when this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use({ 'wbthomason/packer.nvim' })

  -- lua functions that many plugins use
  use({ 'nvim-lua/plenary.nvim' })

  -- preferred colorscheme
  use({ 'folke/tokyonight.nvim' })

  -- maximizes and restores current window
  use({ 'szw/vim-maximizer' })

  -- essential plugins
  use({ 'tpope/vim-surround' }) -- add, delete, change surroundings (it's awesome)
  use({ 'vim-scripts/ReplaceWithRegister' }) -- replace with register contents using motion (gr + motion)
  use({ 'moll/vim-bbye' }) -- closes buffers in a better way
  use({ 'lukas-reineke/indent-blankline.nvim' }) -- adds indentation guides to all lines
  use({ 'akinsho/bufferline.nvim', tag = 'v3.*' }) -- better tabs using buffers
  use({ 'NvChad/nvim-colorizer.lua' }) -- color highlighter
  use({ 'RRethy/vim-illuminate' }) -- highlighs other uses of the word under the cursor
  use({ 'ggandor/leap.nvim' }) -- better motion with "s" keybinding
  use({ 'rcarriga/nvim-notify' }) -- better notifications
  use({ 'nacro90/numb.nvim' }) -- peeks lines of the buffer in non-obtrusive way
  use({ 'folke/todo-comments.nvim' }) -- highlight and search for todo comments like TODO, HACK, BUG
  use({ 'folke/which-key.nvim' }) -- displays a popup with possible key bindings

  -- commenting with gc
  use({ 'numToStr/Comment.nvim' })

  -- file explorer
  use({ 'nvim-tree/nvim-tree.lua' })

  -- vs-code like icons
  use({ 'kyazdani42/nvim-web-devicons' })

  -- startup dashboard
  use({ 'goolord/alpha-nvim' })

  -- statusline
  use({ 'nvim-lualine/lualine.nvim' })

  -- fuzzy finding w/ telescope
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- dependency for better sorting performance
  use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' }) -- fuzzy finder
  use({ 'ahmedkhalf/project.nvim' })

  -- autocompletion
  use({ 'hrsh7th/nvim-cmp' }) -- completion plugin
  use({ 'hrsh7th/cmp-buffer' }) -- source for text in buffer
  use({ 'hrsh7th/cmp-path' }) -- source for file system paths
  use({
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      vim.defer_fn(function()
        require('willian.plugins.copilot')
      end, 100)
    end,
  })
  use({
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    module = 'copilot_cmp',
    config = function()
      require('copilot_cmp').setup({})
    end,
  })

  -- snippets
  use({ 'L3MON4D3/LuaSnip' }) -- snippet engine
  use({ 'saadparwaiz1/cmp_luasnip' }) -- for autocompletion
  use({ 'rafamadriz/friendly-snippets' }) -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  use({ 'williamboman/mason.nvim' }) -- in charge of managing lsp servers, linters & formatters
  use({ 'williamboman/mason-lspconfig.nvim' }) -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  use({ 'neovim/nvim-lspconfig' }) -- easily configure language servers
  use({ 'hrsh7th/cmp-nvim-lsp' }) -- for autocompletion
  use({ 'glepnir/lspsaga.nvim', branch = 'main' }) -- enhanced lsp uis
  use({ 'jose-elias-alvarez/typescript.nvim' }) -- additional functionality for typescript server (e.g. rename file & update imports)
  use({ 'onsails/lspkind.nvim' }) -- vs-code like icons for autocompletion
  use({ 'j-hui/fidget.nvim' }) -- UI for nvim-lsp progress
  use({ 'MunifTanjim/prettier.nvim' }) -- prettier plugin

  -- formatting & linting
  use({ 'jose-elias-alvarez/null-ls.nvim' }) -- configure formatters & linters
  use({ 'jayp0521/mason-null-ls.nvim' }) -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  })
  use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })

  -- auto closing
  use({ 'windwp/nvim-autopairs' }) -- autoclose parens, brackets, quotes, etc...
  use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }) -- autoclose tags

  -- git integration
  use({ 'lewis6991/gitsigns.nvim' }) -- show line modifications on left hand side
  use({ 'f-person/git-blame.nvim' }) -- show git blame info

  -- persist and toggle multiple terminals during an editing session
  use({ 'akinsho/toggleterm.nvim' })
end)
