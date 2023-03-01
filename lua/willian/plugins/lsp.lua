return {
  'VonHeikemen/lsp-zero.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  branch = 'v1.x',
  dependencies = {
    -- LSP Support
    {
      'neovim/nvim-lspconfig',
      event = { 'BufReadPre', 'BufNewFile' },
    },
    {
      'williamboman/mason.nvim',
      keys = {
        { '<leader>lM', '<cmd>Mason<cr>',   desc = 'Open Mason' },
        { '<leader>li', '<cmd>LspInfo<cr>', desc = 'LSP Info' },
      },
    },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp', -- install jsregexp
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load({
            paths = {
              os.getenv('HOME') .. '/.local/share/nvim/lazy/friendly-snippets',
              os.getenv('HOME') .. '/.config/nvim/my_snippets',
            },
          })
        end,
      },
      opts = {
        history = true,
        delete_check_events = 'TextChanged',
      },
      config = function(_, opts)
        local luasnip = require('luasnip')

        luasnip.config.set_config(opts)

        luasnip.filetype_extend('typescript', { 'javascript' })
        luasnip.filetype_extend(
          'typescriptreact',
          { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
        )
        luasnip.filetype_extend('javascriptreact', { 'javascript', 'javascriptreact' })
      end,
    },

    -- additional functionality for typescript server (e.g. rename file & update imports)
    { 'jose-elias-alvarez/typescript.nvim', lazy = true },

    -- Better UI
    { 'onsails/lspkind.nvim' }, -- vs-code like icons for autocompletion

    {
      'glepnir/lspsaga.nvim',
      event = 'BufRead',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
      },
      config = true,
    },
  },
  config = function()
    local lsp = require('lsp-zero').preset({
      name = 'minimal',
      set_lsp_keymaps = false,
      manage_nvim_cmp = true,
      suggest_lsp_servers = true,
    })

    lsp.ensure_installed({
      'cssls',
      'cssmodules_ls',
      'dockerls',
      'emmet_ls',
      'eslint',
      'graphql',
      'html',
      'jsonls',
      'lemminx',
      'lua_ls',
      'prismals',
      'pyright',
      'solargraph',
      'tailwindcss',
      'taplo',
      'tsserver',
      'yamlls',
    })

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local lsp_on_attach = function(client, bufnr)
      -- formatting on save
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- set keybinds
      nmap('gf', '<cmd>Lspsaga lsp_finder<CR>') -- show definition, references
      nmap('gD', vim.lsp.buf.declaration) -- got to declaration
      nmap('gd', '<cmd>Lspsaga goto_definition<CR>') -- see definition and make edits in window
      nmap('gi', vim.lsp.buf.implementation) -- go to implementation
      nmap('[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>') -- jump to previous diagnostic in buffer
      nmap(']e', '<cmd>Lspsaga diagnostic_jump_next<CR>') -- jump to next diagnostic in buffer
      nmap('K', '<cmd>Lspsaga hover_doc<CR>') -- show documentation for what is under cursor
      nmap('<leader>D', '<cmd>Lspsaga show_cursor_diagnostics<CR>') -- show diagnostics for cursor
      nmap('<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>') -- show  diagnostics for line
      nmap('<leader>ca', '<cmd>Lspsaga code_action<CR>') -- see available code actions
      nmap('<leader>lD', '<cmd>Lspsaga show_cursor_diagnostics<CR>') -- show diagnostics for cursor
      nmap('<leader>la', '<cmd>Lspsaga code_action<CR>')
      nmap('<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>') -- show  diagnostics for line
      nmap('<leader>lr', '<cmd>Lspsaga rename<CR>')
      nmap('<leader>rn', '<cmd>Lspsaga rename<CR>')

      -- typescript specific keymaps (e.g. rename file and update imports)
      if client.name == 'tsserver' then
        nmap('<leader>rf', ':TypescriptRenameFile<CR>') -- rename file and update imports
        nmap('<leader>oi', ':TypescriptOrganizeImports<CR>') -- organize imports (not in youtube nvim video)
        nmap('<leader>ru', ':TypescriptRemoveUnused<CR>') -- remove unused variables (not in youtube nvim video)
      end
    end

    lsp.on_attach(lsp_on_attach)

    lsp.configure('tsserver', {
      on_attach = function(client, bufnr)
        lsp_on_attach(client, bufnr)

        local typescript = require('typescript')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_lsp.default_capabilities()

        typescript.setup({
          server = {
            capabilities = capabilities,
            on_attach = lsp_on_attach,
          },
        })
      end,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    })

    local lspkind = require('lspkind')
    lsp.setup_nvim_cmp({
      -- configure lspkind for vs-code like icons
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = '...',
        }),
      },
    })

    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()

    lsp.setup()
  end,
}
