return {
  'bluz71/vim-nightfly-guicolors',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('nightfly')
    vim.g.nightflyTransparent = false
  end,
}
