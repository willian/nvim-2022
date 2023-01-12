-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = { enable = true },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- enable commentstring
  context_commentstring = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'elixir',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'nix',
    'php',
    'phpdoc',
    'prisma',
    'python',
    'regex',
    'ruby',
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
  -- auto install above language parsers
  auto_install = true,
})
