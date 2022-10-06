---@diagnostic disable: missing-parameter
-- For copilot.vim
-- vim.g.copilot_filetypes = {
--   ["*"] = false,
-- }

-- vim.cmd [[
--   imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
--   let g:copilot_no_tab_map = v:true
-- ]]

local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

copilot.setup({
  cmp = {
    enabled = true,
    method = 'getCompletionsCycling',
  },
  panel = { -- no config options yet
    enabled = true,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
  },
  ft_disable = { 'markdown' },
  -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
  server_opts_overrides = {
    -- trace = "verbose",
    settings = {
      advanced = {
        -- listCount = 10, -- #completions for panel
        inlineSuggestCount = 3, -- #completions for getCompletions
      },
    },
  },
  copilot_node_command = vim.fn.expand('$HOME') .. '/.asdf/installs/nodejs/lts/bin/node',
  plugin_manager_path = vim.fn.stdpath('data') .. '/site/pack/packer',
})
