local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup({
  ensure_installed = 'all', -- A list of parser names, or "all"
  ignore_install = { '' }, -- List of parsers to ignore installing (for "all")
  auto_install = true, -- Automatically install missing parsers when entering buffer
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    disable = { '' },
  },
  autopairs = {
    enable = true,
    disable = { '' },
  },
  indent = {
    enable = true,
    disable = { 'python', 'css' },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

--[[ vim.opt.foldmethod = 'expr' ]]
--[[ vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' ]]
