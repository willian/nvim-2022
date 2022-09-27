---@diagnostic disable: missing-parameter
local fn = vim.fn

-- Automatically install packer
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  -- Packer can manage itself
  use({ 'wbthomason/packer.nvim' })

  -- Plugins dependencies
  use({ 'lewis6991/impatient.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'christianchiarulli/lua-dev.nvim' })

  -- General plugins
  use({ 'JoosepAlviste/nvim-ts-context-commentstring' })
  use({ 'ahmedkhalf/project.nvim' })
  use({ 'akinsho/bufferline.nvim' })
  use({ 'akinsho/toggleterm.nvim' })
  use({ 'andymass/vim-matchup' })
  use({ 'dstein64/vim-startuptime' })
  use({ 'f-person/git-blame.nvim' })
  use({ 'folke/todo-comments.nvim' })
  use({ 'folke/which-key.nvim' })
  use({ 'goolord/alpha-nvim' })
  use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } })
  -- use({ 'kylechui/nvim-surround' })
  use({ 'lukas-reineke/indent-blankline.nvim' })
  use({ 'mattn/vim-gist', requires = { 'mattn/webapi-vim' } })
  use({ 'moll/vim-bbye' })
  use({ 'nacro90/numb.nvim' })
  use({ 'numToStr/Comment.nvim' })
  use({ 'nvim-lualine/lualine.nvim' })
  use({ 'rcarriga/nvim-notify' })
  use({ 'windwp/nvim-autopairs' })
  use({ 'windwp/nvim-ts-autotag' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-repeat' })
  -- use({ 'stevearc/dressing.nvim' })
  -- use({ 'github/copilot.vim' })

  -- Colorschemes
  -- use({ 'Julpikar/night-owl.nvim' })
  -- use({ 'bluz71/vim-nightfly-guicolors' })
  use({ 'folke/tokyonight.nvim' })

  -- LSP
  use({ 'neovim/nvim-lspconfig' })
  use({ 'williamboman/mason.nvim' })
  use({ 'williamboman/mason-lspconfig.nvim' })
  use({ 'jose-elias-alvarez/null-ls.nvim' }) -- for formatters and linters
  use({ 'ray-x/lsp_signature.nvim' })
  use({ 'glepnir/lspsaga.nvim' })
  use({ 'b0o/SchemaStore.nvim' })
  use({ 'j-hui/fidget.nvim' }) -- UI for nvim-lsp progress
  use({ 'RRethy/vim-illuminate' })
  -- use({ 'princejoogie/tailwind-highlight.nvim' })
  use({ 'lvimuser/lsp-inlayhints.nvim' })
  -- use('https://git.sr.ht/~whynothugo/lsp_lines.nvim')
  use({
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      vim.defer_fn(function()
        require('nvim.plugins.copilot')
      end, 100)
    end,
  })
  use({ 'MunifTanjim/prettier.nvim' })

  -- Completion
  use({ 'hrsh7th/nvim-cmp', requires = {
    'L3MON4D3/LuaSnip',
  } })
  use({ 'hrsh7th/cmp-buffer' }) -- buffer completions
  use({ 'hrsh7th/cmp-cmdline' }) -- cmdline completions
  use({ 'hrsh7th/cmp-emoji' })
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-nvim-lua' })
  use({ 'hrsh7th/cmp-path' }) -- path completions
  use({ 'saadparwaiz1/cmp_luasnip' }) -- snippet completions
  -- use({
  --   'tzachar/cmp-tabnine',
  --   commit = '1a8fd2795e4317fd564da269cc64a2fa17ee854e',
  --   run = './install.sh',
  -- })
  use({
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup({
        method = 'getCompletionsCycling',
      })
    end,
  })

  -- Snippets
  use({ 'L3MON4D3/LuaSnip', wants = 'friendly-snippets' })
  use({ 'rafamadriz/friendly-snippets' })

  -- Telescope
  use({ 'nvim-telescope/telescope.nvim' })

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter' })
  use({
    'abecodes/tabout.nvim',
    wants = { 'nvim-treesitter' }, -- or require if not used so far
  })
  use({ 'nvim-treesitter/nvim-treesitter-context' })

  -- Git
  use({ 'lewis6991/gitsigns.nvim' })

  -- -- Session
  -- use({ 'rmagatti/auto-session' })
  -- use({ 'rmagatti/session-lens' })

  -- Color
  use({ 'NvChad/nvim-colorizer.lua' })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
