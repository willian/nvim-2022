-- colorscheme
return {
  -- {
  --   'bluz71/vim-nightfly-guicolors',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('nightfly')
  --     vim.g.nightflyTransparent = false
  --     vim.g.nightflyItalics = true
  --     vim.g.nightflyNormalFloat = true
  --     vim.g.nightflyVirtualTextColor = true
  --     vim.g.nightflyWinSeparator = 2
  --
  --     vim.opt.fillchars = {
  --       horiz = '━',
  --       horizup = '┻',
  --       horizdown = '┳',
  --       vert = '┃',
  --       vertleft = '┫',
  --       vertright = '┣',
  --       verthoriz = '╋',
  --     }
  --   end,
  -- },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
