local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end
--
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
  debug = false,
  default_timeout = -1,
  sources = {
    code_actions.eslint_d,
    -- diagnostics.eslint_d,
    formatting.eslint_d,
    -- formatting.prettier,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd('nnoremap <silent><buffer> <Leader>lf :lua vim.lsp.buf.formatting()<CR>')

      -- format on save
      vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd('xnoremap <silent><buffer> <Leader>lf :lua vim.lsp.buf.range_formatting({})<CR>')
    end
  end,
})
