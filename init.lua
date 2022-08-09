-- compile the lua code to bitecode so neovim start up faster
pcall(require, 'impatient')
require('nvim')
