local status_ok, saga = pcall(require, 'lspsaga')
if not status_ok then
  return
end

saga.init_lsp_saga({
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
