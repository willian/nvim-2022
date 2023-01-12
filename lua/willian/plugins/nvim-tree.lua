-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, 'nvim-tree')
if not setup then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#394B70 ]])

-- configure nvim-tree
nvimtree.setup({
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = 'none',
    root_folder_modifier = ':t',
    indent_markers = {
      enable = true,
      icons = {
        corner = '└',
        edge = '│ ',
        none = '  ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        folder = {
          arrow_closed = '▸', -- arrow when folder is closed
          arrow_open = '▾', -- arrow when folder is open
        },
        git = {
          unstaged = '',
          staged = 'S',
          unmerged = '',
          renamed = '➜',
          untracked = 'U',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = 'left',
    mappings = {
      list = {
        { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'v', cb = tree_cb('vsplit') },
        { key = { '+', '=' }, cb = '<CMD>lua require("nvim-tree").resize("+10")<CR>' },
        { key = { '-' }, cb = '<CMD>lua require("nvim-tree").resize("-10")<CR>' },
        { key = { '0' }, cb = '<CMD>lua require("nvim-tree").resize(30)<CR>' },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false,
      },
    },
  },
})
