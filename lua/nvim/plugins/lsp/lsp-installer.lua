local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

local servers = {
  'bashls',
  'cssls',
  'cssmodules_ls',
  'dockerls',
  'emmet_ls',
  'eslint',
  'graphql',
  'html',
  'jsonls',
  'prismals',
  'solargraph',
  'sumneko_lua',
  'tailwindcss',
  'taplo',
  'tsserver',
  'yamlls',
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

-- local tw_highlight_status_ok, tw_highlight = pcall(require, 'tailwind-highlight')
-- if not tw_highlightlspconfig_status_ok then
--   return
-- end

local handlers = require('nvim.plugins.lsp.handlers')
local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  if server == 'sumneko_lua' then
    local sumneko_opts = require('nvim.plugins.lsp.settings.sumneko_lua')
    opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
  elseif server == 'tsserver' then
    local tsserver_opts = require('nvim.plugins.lsp.settings.tsserver')
    opts = vim.tbl_deep_extend('force', tsserver_opts, opts)
    -- elseif server == 'tailwindcss' then
    --   opts = {
    --     on_attach = function(client, bufnr)
    --       tw_highlight.setup(client, bufnr, {
    --         single_column = false,
    --         mode = 'background',
    --         debounce = 200,
    --       })
    --     end,
    --   }
  end

  lspconfig[server].setup(opts)
end

-- lspconfig.tailwindcss.setup({
--   on_attach = function(client, bufnr)
--     -- rest of you config
--     tw_highlight.setup(client, bufnr, {
--       single_column = false,
--       mode = 'background',
--       debounce = 200,
--     })
--   end,
-- })
