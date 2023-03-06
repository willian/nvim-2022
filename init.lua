-- Set <space> as the leader key
-- See 
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use lazy.nvim a the package manager
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

-- Initialize lazy.nvim
require('lazy').setup('willian.plugins', {})

-- Custom configurations
require('willian.options')
require('willian.keymaps')
require('willian.autocmds')
