local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('nvim.plugins.lsp.lsp-installer')
require('nvim.plugins.lsp.handlers').setup()
require('nvim.plugins.lsp.null-ls')
require('nvim.plugins.lsp.fidget')
