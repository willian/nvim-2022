-- import mason plugin safely
local mason_status, mason = pcall(require, 'mason')
if not mason_status then
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status then
  return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_status then
  return
end

-- enable mason
mason.setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '◍',
      package_pending = '◍',
      package_uninstalled = '◍',
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    'cssls',
    'cssmodules_ls',
    'dockerls',
    'emmet_ls',
    'eslint',
    'graphql',
    'html',
    'jsonls',
    'lemminx',
    'prismals',
    'pyright',
    'solargraph',
    'sumneko_lua',
    'tailwindcss',
    'taplo',
    'tsserver',
    'yamlls',
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
    'eslint_d', -- ts/js linter
    'prettierd', -- ts/js formatter
    'stylua', -- lua formatter
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})