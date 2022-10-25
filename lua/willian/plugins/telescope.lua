local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local actions_status_ok, actions = pcall(require, 'telescope.actions')
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    path_display = { 'smart' },
    file_ignore_patterns = { '.git/', 'node_modules' },
    mappings = {
      i = {
        ['<Down>'] = actions.move_selection_next, -- move to next result
        ['<Up>'] = actions.move_selection_previous, -- move to prev result
        ['<C-k>'] = actions.move_selection_previous, -- move to prev result
        ['<C-j>'] = actions.move_selection_next, -- move to next result
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('projects')
