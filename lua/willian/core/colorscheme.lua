local status_ok, _ = pcall(vim.cmd, 'colorscheme tokyonight-storm')
if not status_ok then
  -- print error if colorscheme not installed
  print('Colorscheme not found!')
  return
end
