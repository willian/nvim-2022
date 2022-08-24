local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup({
  ensure_installed = 'all', -- A list of parser names, or "all"
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { '' }, -- List of parsers to ignore installing (for "all")
  auto_install = true, -- Automatically install missing parsers when entering buffer
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable_virtual_text = true,
    disable = { 'html' }, -- optional, list of language that will be disabled
    -- include_match_words = false
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    disable = { 'markdown' },
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { 'python', 'css', 'rust' },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
    disable = { 'xml', 'markdown' },
  },
})

--[[ vim.opt.foldmethod = 'expr' ]]
--[[ vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' ]]
