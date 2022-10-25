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
  button('f', '  Find file', ':Telescope find_files<CR>'),
  button('n', '  New file', ':ene <BAR> startinsert<CR>'),
  button('p', '  Find project', ':Telescope projects<CR>'),
  button('r', '  Recent files', ':Telescope oldfiles<CR>'),
  button('s', '  Find text', ':Telescope live_grep<CR>'),
  button('u', '  Update', ':PackerSync<CR>'),
  button('c', '  Config', ':e ~/.config/nvim/init.lua <CR>'),
  button('q', '  Quit', ':qa<CR>'),
}

dashboard.section.footer.val = os.date()

dashboard.section.footer.opts.hl = 'DashboardFooter'
dashboard.section.header.opts.hl = 'DashboardHeader'

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)