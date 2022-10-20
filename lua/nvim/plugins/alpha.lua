local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

local dashboard = require('alpha.themes.dashboard')

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = 'DashboardShortCut'
  return b
end

local icons = require('nvim.core.icons')

dashboard.section.header.val = {
  '',
  '',
  [[    ⠀⠀⠀⣠⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[    ⠀⣴⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[    ⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⣀⠶⠋⠉⠙⢿⣄⠀⠀⣠⡾⠋⠉⠉⠛⣦⠀⠀⣠⡾⠛⠉⠉⠛⣶⡀⠙⣿⣿⠀⠀⠀⠀⣿⣿⡟⢸⣿⣿⠀⢸⣿⣿⣿⠿⠿⣿⣿⣶⣿⠿⢿⣿⣿⡄    ]],
  [[    ⣿⣿⣿⣿⣿⠙⣿⣿⣿⣿⣿⣆⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢸⣏⣀⣀⣀⣀⣀⣈⡇⢰⡟⠀⠀⠀⠀⠀⠀⣿⡀⠹⣿⣿⠀⠀⣾⣿⡟⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿    ]],
  [[    ⣿⣿⣿⣿⣿⠀⠈⢿⣿⣿⣿⣿⣷⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢿⡇⠀⠀⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⠀⣿⡇⠀⢻⣿⣷⣰⣿⡿⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿    ]],
  [[    ⣿⣿⣿⣿⣿⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⠈⣿⡀⠀⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀⠀⣠⡿⠀⠀⠀⢿⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿    ]],
  [[    ⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠙⠁⠀⠀⠀⠀⠀⠛⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠈⠛⠛⠀⠈⠛⠛⠀⠀⠀⠘⠛⠛⠀⠀⠀⠙⠛⠋    ]],
  [[    ⠙⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[    ⠀⠀⠈⢿⣿⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⡿⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[    ⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
}
dashboard.section.header.opts.position = 'center'

dashboard.section.buttons.val = {
  button('f', icons.documents.Files .. 'Find file', ':Telescope find_files <CR>'),
  button('n', icons.ui.NewFile .. 'New file', ':ene <BAR> startinsert <CR>'),
  button(
    'p',
    icons.git.Repo .. 'Find project',
    ":lua require('telescope').extensions.projects.projects()<CR>"
  ),
  button('r', icons.ui.History .. 'Recent files', ':Telescope oldfiles <CR>'),
  button('t', icons.ui.List .. 'Find text', ':Telescope live_grep <CR>'),
  button('s', icons.ui.SignIn .. 'Find Session', ':SearchSession<CR>'),
  button('u', icons.ui.CloudDownload .. 'Update', ':PackerSync<CR>'),
  button('c', icons.ui.Gear .. 'Config', ':e ~/.config/nvim/init.lua <CR>'),
  button('q', icons.ui.SignOut .. 'Quit', ':qa<CR>'),
}

---@diagnostic disable-next-line: assign-type-mismatch
dashboard.section.footer.val = os.date()

dashboard.section.footer.opts.hl = 'DashboardFooter'
dashboard.section.header.opts.hl = 'DashboardHeader'

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
