---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- sources
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      -- snippets
      { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',

      -- vs-code like icons for autocompletio
      'onsails/lspkind.nvim',

      -- formatting & linting
      'jose-elias-alvarez/null-ls.nvim', -- configure formatters & linters
      'jayp0521/mason-null-ls.nvim', -- bridges gap b/w mason & null-ls
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- load friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- helper function for super tab functionality
      local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
            == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- super tab functionality (not in youtube nvim video)
          ['<Tab>'] = cmp.mapping(function(fallback) -- use tab for next suggestion
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback) -- use shift-tab for prev suggestion
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }, -- lsp
          { name = 'luasnip' }, -- snippets
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
        }),

        -- configure lspkind for vs-code like icons
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- managing & installing lsp servers, linters, and formatters
      'williamboman/mason.nvim', -- in charge of managing lsp servers, linters & formatters
      'williamboman/mason-lspconfig.nvim', -- bridges gap b/w mason & lspconfig

      -- configuring lsp servers
      'hrsh7th/cmp-nvim-lsp', -- for autocompletion
      'glepnir/lspsaga.nvim', -- enhanced lsp uis
      'jose-elias-alvarez/typescript.nvim', -- additional functionality for typescript server (e.g. rename file & update imports)
      -- 'j-hui/fidget.nvim', -- UI for nvim-lsp progress
      -- 'MunifTanjim/prettier.nvim', -- prettier plugin
    },
    config = function()
      local lsp_servers = {
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
      }

      -- Mason config
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local mason_null_ls = require('mason-null-ls')

      mason.setup()

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = lsp_servers,
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })

      mason_null_ls.setup({
        ensure_installed = {
          'eslint_d', -- ts/js linter
          'prettier', -- ts/js formatter
          'stylua', -- lua formatter
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      })

      -- Lspsaga
      local saga = require('lspsaga')

      saga.setup({
        -- keybinds for navigation in lspsaga window
        move_in_saga = { prev = '<Up>', next = '<Down>' },
        -- use enter to open file with finder
        finder_action_keys = {
          open = '<CR>',
        },
        -- use enter to open file with definition preview
        definition_action_keys = {
          edit = '<CR>',
        },
      })

      -- LSPConfig
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local typescript = require('typescript')

      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }

          vim.keymap.set('n', keys, func, opts)
        end

        -- set keybinds
        nmap('gf', '<cmd>Lspsaga lsp_finder<CR>', 'References') -- show definition, references
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration') -- got to declaration
        nmap('gd', '<cmd>Lspsaga goto_definition<CR>', 'Goto Definition') -- see definition and make edits in window
        nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation') -- go to implementation
        nmap('[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Next Error') -- jump to previous diagnostic in buffer
        nmap(']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Prev Error') -- jump to next diagnostic in buffer
        nmap('K', '<cmd>Lspsaga hover_doc<CR>', 'Show documentation') -- show documentation for what is under cursor
        nmap('<leader>D', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'Cursor Diagnostic') -- show diagnostics for cursor
        nmap('<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Line Diagnostics') -- show  diagnostics for line
        nmap('<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code Action') -- see available code actions
        nmap('<leader>cr', '<cmd>Lspsaga rename<CR>', 'Rename')
        nmap('<leader>lD', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'Cursor Diagnostic') -- show diagnostics for cursor
        nmap('<leader>la', '<cmd>Lspsaga code_action<CR>', 'Code Action')
        nmap('<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Line Diagnostics') -- show  diagnostics for line
        nmap('<leader>lr', '<cmd>Lspsaga rename<CR>', 'Rename')

        -- typescript specific keymaps (e.g. rename file and update imports)
        if client.name == 'tsserver' then
          nmap('<leader>rf', ':TypescriptRenameFile<CR>', '[TS] Rename File') -- rename file and update imports
          nmap('<leader>oi', ':TypescriptOrganizeImports<CR>', '[TS] Organize Imports') -- organize imports (not in youtube nvim video)
          nmap('<leader>ru', ':TypescriptRemoveUnused<CR>', '[TS] Remove Unused') -- remove unused variables (not in youtube nvim video)
        end
      end

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      for _, server in pairs(lsp_servers) do
        if server == 'tsserver' then
          -- configure typescript server
          typescript.setup({
            server = {
              capabilities = capabilities,
              on_attach = on_attach,
            },
          })
        elseif server == 'lua_ls' then
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
        else
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end

      -- linters and formatters
      local null_ls = require('null-ls')
      -- for conciseness
      local formatting = null_ls.builtins.formatting -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters

      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      null_ls.setup({
        sources = {
          formatting.prettier, -- js/ts formatter
          formatting.stylua, -- lua formatter
          diagnostics.eslint_d, -- js/ts linter
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    -- only use null-ls for formatting instead of lsp server
                    return client.name == 'null-ls'
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
