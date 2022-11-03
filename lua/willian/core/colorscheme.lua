-- local status_ok, _ = pcall(require, 'tokyonight')
-- if not status_ok then
--   return
-- end
--
-- local colorscheme_status_ok, _ = pcall(vim.cmd, 'colorscheme tokyonight-storm')
-- if not colorscheme_status_ok then
--   print('Colorscheme not found!')
--   return
-- end
--
-- local colors = require('tokyonight.colors').setup()
--
-- -- tokyonight.setup({
-- --   on_highlights = function(hl, colors)
-- --     hl.ColorColumn = { bg = colors.red }
-- --     hl.Comment = { fg = colors.red }
-- --   end,
-- -- })
--
-- vim.api.nvim_command('highlight ColorColumn guibg=' .. colors.bg_highlight)
-- vim.api.nvim_command('highlight CursorLineNr guibg=' .. colors.bg_highlight)

local colorscheme_status_ok, _ = pcall(vim.cmd, 'colorscheme nightfly')
if not colorscheme_status_ok then
  print('Colorscheme not found!')
  return
end

vim.g.nightflyTransparent = true
