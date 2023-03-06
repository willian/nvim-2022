return {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- last release is way too old and doesn't work on Windows
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter']
        local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
        local enabled = false
        if opts.textobjects then
          for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              enabled = true
              break
            end
          end
        end
        if not enabled then
          require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
        end
      end,
    },
    {
      'windwp/nvim-ts-autotag',
    },
  },
  keys = {
    { '<c-space>', desc = 'Increment selection' },
    { '<bs>', desc = 'Schrink selection', mode = 'x' },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    autotag = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dockerfile',
      'elixir',
      'gitignore',
      'go',
      'graphql',
      'help',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'nix',
      'php',
      'phpdoc',
      'prisma',
      'python',
      'query',
      'regex',
      'ruby',
      'rust',
      'scss',
      'sql',
      'svelte',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vue',
      'yaml',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = '<nop>',
        node_decremental = '<bs>',
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
