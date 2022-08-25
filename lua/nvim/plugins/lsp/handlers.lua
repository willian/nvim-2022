local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
  return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  local icons = require('nvim.core.icons')
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'if_many', -- Or "always"
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  keymap(bufnr, 'n', 'gD', '<cmd>Telescope lsp_declarations<CR>', opts)
  keymap(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  keymap(bufnr, 'n', 'gI', '<cmd>Telescope lsp_implementations<CR>', opts)
  keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  keymap(bufnr, 'n', 'gl', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
  keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '[e', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
  keymap(bufnr, 'n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
  keymap(bufnr, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  keymap(bufnr, 'n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  keymap(bufnr, 'n', '<leader>lM', '<cmd>Mason<cr>', opts)
  keymap(bufnr, 'n', '<leader>la', '<cmd>Lspsaga code_action<cr>', opts)
  keymap(bufnr, 'n', '<leader>lj', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
  keymap(bufnr, 'n', '<leader>lk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
  keymap(bufnr, 'n', '<leader>lr', '<cmd>Lspsaga rename<cr>', opts)
  keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.name == 'tsserver' then
    local status_lsp_inlayhints, lsp_inlayhints = pcall(require, 'lsp-inlayhints')
    if not status_lsp_inlayhints then
      return
    end

    lsp_inlayhints.on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  if client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
    augroup end
  ]])
  vim.notify('Enabled format on save')
end

function M.disable_format_on_save()
  M.remove_augroup('format_on_save')
  vim.notify('Disabled format on save')
end

function M.toggle_format_on_save()
  if vim.fn.exists('#format_on_save#BufWritePre') == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists('#' .. name) == 1 then
    vim.cmd('au! ' .. name)
  end
end

vim.cmd(
  [[ command! LspToggleAutoFormat execute 'lua require("nvim.plugins.lsp.handlers").toggle_format_on_save()' ]]
)

return M
