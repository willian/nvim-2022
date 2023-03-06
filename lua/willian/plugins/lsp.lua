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
        { '<leader>lM', '<cmd>Mason<cr>', desc = 'LSP: Open Mason' },
        { '<leader>li', '<cmd>LspInfo<cr>', desc = 'LSP: Info' },
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

    -- nvim-lsp progress_as
    {
      'j-hui/fidget.nvim',
      config = true,
    },

    { 'onsails/lspkind.nvim' }, -- vs-code like icons for autocompletion

    {
      'glepnir/lspsaga.nvim',
      event = 'BufRead',
      config = true,
    },

    -- formatting & linting
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'jayp0521/mason-null-ls.nvim', -- bridges gap b/w mason & null-ls
      },
    },

    {
      'MunifTanjim/prettier.nvim',
      opts = {
        bin = 'prettierd',
        cli_options = {
          arrow_parens = 'avoid',
          bracket_spacing = false,
          jsx_bracket_same_line = false,
          print_width = 100,
          prose_wrap = 'always',
          require_config = true,
          semi = false,
          single_quote = true,
          tab_width = 2,
          trailing_comma = 'all',
          use_tabs = false,
        },
      },
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

        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
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

    local null_ls = require('null-ls')
    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    local eslint_d_settings = {
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file('.eslintrc.js') or utils.root_has_file('.eslintrc.json') -- change file extension if you use something else
      end,
    }

    -- configure null_ls
    null_ls.setup({
      -- setup formatters & linters
      sources = {
        -- to disable file types use
        -- "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        formatting.prettierd, -- js/ts formatter
        formatting.stylua, -- lua formatter
        -- formatting.eslint_d.with(eslint_d_settings), -- format with eslint
        diagnostics.eslint_d.with(eslint_d_settings), -- js/ts linter
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

    -- local null_ls = require('null-ls')
    --
    -- local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
    -- local event = 'BufWritePre' -- or "BufWritePost"
    -- local async = event == 'BufWritePost'
    --
    -- null_ls.setup({
    --   on_attach = function(client, bufnr)
    --     if client.supports_method('textDocument/formatting') then
    --       vim.keymap.set('n', '<leader>lf', function()
    --         vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    --       end, { buffer = bufnr, desc = '[lsp] format' })
    --
    --       -- format on save
    --       vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    --       vim.api.nvim_create_autocmd(event, {
    --         buffer = bufnr,
    --         group = group,
    --         callback = function()
    --           vim.lsp.buf.format({ bufnr = bufnr, async = async })
    --         end,
    --         desc = '[lsp] format on save',
    --       })
    --     end
    --
    --     if client.supports_method('textDocument/rangeFormatting') then
    --       vim.keymap.set('x', '<leader>lf', function()
    --         vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    --       end, { buffer = bufnr, desc = '[lsp] format' })
    --     end
    --   end,
    --   sources = {
    --     null_ls.builtins.formatting.prettierd,
    --     null_ls.builtins.formatting.stylua, -- lua formatter
    --     null_ls.builtins.diagnostics.eslint_d,
    --   },
    -- })
    --
    -- local null_ls = require('null-ls')
    -- local null_opts = lsp.build_options('null-ls', {})
    --
    -- local eslint_d_settings = {
    --   -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
    --   condition = function(utils)
    --     -- change file extension if you use something else
    --     local hasEslintrcFile = utils.root_has_file('.eslintrc.js')
    --       or utils.root_has_file('.eslintrc.json')
    --       or utils.root_has_file('.eslintrc')
    --
    --     if hasEslintrcFile then
    --       print('.eslintrc file found')
    --     end
    --
    --     return hasEslintrcFile
    --   end,
    -- }
    --
    -- null_ls.setup({
    --   on_attach = null_opts.on_attach,
    --   -- setup formatters & linters
    --   sources = {
    --     null_ls.builtins.formatting.prettierd, -- js/ts formatter
    --     null_ls.builtins.formatting.stylua, -- lua formatter
    --     null_ls.builtins.diagnostics.eslint_d.with(eslint_d_settings), -- js/ts linter
    --     -- null_ls.builtins.code_actions.eslint_d,
    --     -- null_ls.builtins.formatting.eslint_d.with(eslint_d_settings),
    --     -- null_ls.builtins.completion.spell,
    --   },
    -- })

    local mason_null_ls = require('mason-null-ls')

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
  end,
}
