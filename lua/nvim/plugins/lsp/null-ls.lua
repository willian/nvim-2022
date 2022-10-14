local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- only use null-ls when formatting files
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

-- use this as a callback when formatting on save
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

---@diagnostic disable-next-line: redundant-parameter
null_ls.setup({
  debug = false,
  sources = {
    code_actions.eslint_d,
    formatting.eslint_d,
    -- formatting.prettier,
    formatting.black.with({ extra_args = { '--fast' } }),
    formatting.stylua,
  },
  ---@diagnostic disable-next-line: unused-local
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'rust' },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find('unwrap()')
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = 'unwrap',
            message = 'hey ' .. os.getenv('USER') .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(unwrap)
