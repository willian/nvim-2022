-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, 'typescript')
if not typescript_setup then
  return
end

local keymap = vim.keymap.set -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap('n', 'gf', '<cmd>Lspsaga lsp_finder<CR>', opts) -- show definition, references
  keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- got to declaration
  keymap('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts) -- see definition and make edits in window
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- go to implementation
  keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts) -- jump to previous diagnostic in buffer
  keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts) -- jump to next diagnostic in buffer
  keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts) -- show documentation for what is under cursor
  keymap('n', '<leader>D', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts) -- show diagnostics for cursor
  keymap('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', opts) -- show  diagnostics for line
  keymap('n', '<leader>o', '<cmd>LSoutlineToggle<CR>', opts) -- see outline on right hand side
  keymap('n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  keymap('n', '<leader>lM', '<cmd>Mason<cr>', opts)
  keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts) -- see available code actions
  keymap('n', '<leader>la', '<cmd>Lspsaga code_action<cr>', opts)
  keymap('n', '<leader>lr', '<cmd>Lspsaga rename<cr>', opts)
  keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts) -- smart rename

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == 'tsserver' then
    keymap('n', '<leader>rf', ':TypescriptRenameFile<CR>') -- rename file and update imports
    keymap('n', '<leader>oi', ':TypescriptOrganizeImports<CR>') -- organize imports (not in youtube nvim video)
    keymap('n', '<leader>ru', ':TypescriptRemoveUnused<CR>') -- remove unused variables (not in youtube nvim video)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = 'ﴞ ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local servers = {
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
}

for _, server in pairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  if server == 'tsserver' then
    -- configure tailwindcss server
    typescript.setup({
      server = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
    })
  end

  if server == 'sumneko_lua' then
    -- configure lua server (with special settings)
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize 'vim' global
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })
  end
end
