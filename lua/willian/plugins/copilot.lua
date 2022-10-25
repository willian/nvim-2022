---@diagnostic disable: missing-parameter
local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

copilot.setup({
  server_opts_overrides = {
    settings = {
      advanced = {
        inlineSuggestCount = 3, -- #completions for getCompletions
      },
    },
  },
  copilot_node_command = vim.fn.expand('$HOME') .. '/.asdf/installs/nodejs/lts/bin/node',
  plugin_manager_path = vim.fn.stdpath('data') .. '/site/pack/packer',
})
