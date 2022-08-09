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

  -- Common plugins
  use({ 'JoosepAlviste/nvim-ts-context-commentstring' })
  use({ 'ahmedkhalf/project.nvim' })
  use({ 'akinsho/bufferline.nvim' })
  use({ 'akinsho/toggleterm.nvim' })
  use({ 'dstein64/vim-startuptime' })
  use({ 'folke/todo-comments.nvim' })
  use({ 'folke/which-key.nvim' })
  use({ 'github/copilot.vim' })
  use({ 'goolord/alpha-nvim' })
  use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } })
  use({ 'lukas-reineke/indent-blankline.nvim' })
  use({ 'moll/vim-bbye' })
  use({ 'numToStr/Comment.nvim' })
  use({ 'nvim-lualine/lualine.nvim' })
  -- use({ 'windwp/nvim-autopairs' })

  -- Colorschemes
  use({ 'Julpikar/night-owl.nvim' })
  use({ 'bluz71/vim-nightfly-guicolors' })

  -- cmp plugins
  use({ 'hrsh7th/nvim-cmp' })
  use({ 'hrsh7th/cmp-buffer' }) -- buffer completions
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-nvim-lua' })
  use({ 'hrsh7th/cmp-path' }) -- path completions
  use({ 'saadparwaiz1/cmp_luasnip' }) -- snippet completions

  -- Snippets
  use({ 'L3MON4D3/LuaSnip' })
  use({ 'rafamadriz/friendly-snippets' })

  -- LSP
  use({ 'neovim/nvim-lspconfig' })
  use({ 'williamboman/nvim-lsp-installer' })
  --[[ use({ 'williamboman/mason.nvim' }) ]]
  --[[ use({ 'williamboman/mason-lspconfig.nvim' }) ]]
  use({ 'jose-elias-alvarez/null-ls.nvim' }) -- for formatters and linters
  --[[ use({ 'ray-x/lsp_signature.nvim' }) ]]
  --[[ use({ 'SmiteshP/nvim-navic' }) -- substitues bufferline and lualine ]]
  --[[ use({ 'b0o/SchemaStore.nvim' }) ]]
  use({ 'j-hui/fidget.nvim' }) -- UI for nvim-lsp progress
  use({ 'RRethy/vim-illuminate' })
  use({ 'princejoogie/tailwind-highlight.nvim' })

  -- Telescope
  use({ 'nvim-telescope/telescope.nvim' })

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter' })

  -- Git
  use({ 'lewis6991/gitsigns.nvim' })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
