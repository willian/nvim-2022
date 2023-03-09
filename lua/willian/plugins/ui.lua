return {
  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Delete all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      vim.opt.termguicolors = true -- turn on termguicolors for the colorscheme to work
      vim.notify = require('notify')
    end,
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
      {
        '<leader>bP',
        '<Cmd>BufferLineGroupClose ungrouped<CR>',
        desc = 'Delete non-pinned buffers',
      },
    },
    opts = function()
      local use_icons = true

      local function is_ft(b, ft)
        return vim.bo[b].filetype == ft
      end

      local function diagnostics_indicator(num, _, diagnostics, _)
        local table_result = {}
        local result = ''
        local symbols = {
          error = ' ',
          hint = ' ',
          info = ' ',
          warning = ' ',
        }

        if not use_icons then
          return '(' .. num .. ')'
        end

        for name, count in pairs(diagnostics) do
          if symbols[name] and count > 0 then
            table.insert(table_result, symbols[name] .. ' ' .. count)
          end
        end

        result = table.concat(table_result, ' ')

        return #result > 0 and result or ''
      end

      local function custom_filter(buf, buf_nums)
        local logs = vim.tbl_filter(function(b)
          return is_ft(b, 'log')
        end, buf_nums)

        if vim.tbl_isempty(logs) then
          return true
        end

        local tab_num = vim.fn.tabpagenr()
        local last_tab = vim.fn.tabpagenr('$')
        local is_log = is_ft(buf, 'log')

        if last_tab == 1 then
          return true
        end

        -- only show log buffers in secondary tabstop
        return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
      end

      return {
        options = {
          always_show_bufferline = true,
          buffer_close_icon = ' ',
          close_command = 'Bdelete! %d',
          close_icon = ' ',
          custom_filter = custom_filter, -- NOTE: this will be called a lot so don't do any heavy processing here
          diagnostics = 'nvim_lsp',
          diagnostics_update_in_insert = false,
          diagnostics_indicator = diagnostics_indicator,
          enforce_regular_tabs = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },
          indicator = { icon = '▎', style = 'icon' },
          left_mouse_command = 'buffer %d',
          left_trunc_marker = ' ',
          max_name_length = 30,
          max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
          middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
          modified_icon = '● ',
          numbers = 'none',
          offsets = {
            {
              filetype = 'NvimTree',
              text = '',
              padding = 1,
            },
            {
              filetype = 'neo-tree',
              text = 'Neo-tree',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          right_mouse_command = 'Bdelete! %d',
          right_trunc_marker = ' ',
          separator_style = 'thin',
          show_buffer_close_icons = use_icons,
          show_buffer_icons = use_icons,
          show_close_icon = false,
          show_tab_indicators = true,
          tab_size = 21,
        },
        highlights = {
          background = {
            italic = true,
          },
          buffer_selected = {
            bold = true,
          },
        },
      }
    end,
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local colors = {
        bg = '#1F2335',
        yellow = '#E0AF68',
        green = '#9ECE6A',
        red = '#F7768E',
      }

      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 70
      end

      local mode = {
        function()
          return ' '
        end,
        padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
      }

      local branch = {
        'b:gitsigns_head',
        icon = '',
        color = { gui = 'bold' },
        cond = hide_in_width,
      }

      local filename = {
        'filename',
        color = {},
        cond = nil,
        path = 1,
      }

      local diff = {
        'diff',
        source = diff_source,
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red },
        },
        cond = nil,
      }

      local diagnostics = {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        cond = hide_in_width,
      }

      local treesitter = {
        function()
          local b = vim.api.nvim_get_current_buf()
          if next(vim.treesitter.highlighter.active[b]) then
            return ''
          end
          return ''
        end,
        color = { fg = colors.green },
        cond = hide_in_width,
      }

      local lsp = {
        function(msg)
          msg = msg or 'LS Inactive'
          local buf_clients = vim.lsp.get_active_clients()
          if next(buf_clients) == nil then
            -- TODO: clean up this if statement
            if type(msg) == 'boolean' or #msg == 0 then
              return 'LS Inactive'
            end
            return msg
          end
          local buf_ft = vim.bo.filetype
          local buf_client_names = {}

          -- add client
          for _, client in pairs(buf_clients) do
            if client.name ~= 'null-ls' then
              table.insert(buf_client_names, client.name)
            end
          end

          -- add formatter
          local formatters = require('vim.lsp.null-ls.formatters')
          local supported_formatters = formatters.list_registered(buf_ft)
          vim.list_extend(buf_client_names, supported_formatters)

          -- add linter
          local linters = require('vim.lsp.null-ls.linters')
          local supported_linters = linters.list_registered(buf_ft)
          vim.list_extend(buf_client_names, supported_linters)

          local unique_client_names = vim.fn.uniq(buf_client_names)
          return '[' .. table.concat(unique_client_names, ', ') .. ']'
        end,
        color = { gui = 'bold' },
        cond = hide_in_width,
      }

      local filetype = {
        'filetype',
        icons_enabled = false,
      }

      local scrollbar = {
        function()
          local current_line = vim.fn.line('.')
          local total_lines = vim.fn.line('$')
          local chars =
            { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
          local line_ratio = current_line / total_lines
          local index = math.ceil(line_ratio * #chars)
          return chars[index]
        end,
        padding = { left = 0, right = 0 },
        color = { fg = colors.yellow, bg = colors.bg },
        cond = nil,
      }

      return {
        options = {
          component_separators = { left = '', right = '' },
          disabled_filetypes = {
            'alpha',
            'dashboard',
            'lazy',
            'neo-tree',
            'NvimTree',
          },
          globalstatus = false,
          icons_enabled = true,
          section_separators = { left = '', right = '' },
          theme = 'auto',
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { branch, filename },
          lualine_c = { diff },
          lualine_x = { diagnostics, treesitter, lsp, filetype },
          lualine_y = {},
          lualine_z = { scrollbar },
        },
      }
    end,
  },

  -- indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
      filetype_exclude = {
        'help',
        'alpha',
        'dashboard',
        'NvimTree',
        'Trouble',
        'lazy',
        'TelescopePrompt',
        'text',
        'toggleterm',
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      context_highlight_list = { 'SpecialKey', 'Operator', 'Statement' },
    },
  },

  -- active indent guide and indent text objects
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'lazy', 'mason' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require('alpha.themes.dashboard')

      local function button(sc, txt, keybind, keybind_opts)
        local b = dashboard.button(sc, txt, keybind, keybind_opts)
        b.opts.hl_shortcut = 'Type'
        return b
      end

      local logo = [[
    ⠀⠀⠀⣠⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⣴⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⣀⠶⠋⠉⠙⢿⣄⠀⠀⣠⡾⠋⠉⠉⠛⣦⠀⠀⣠⡾⠛⠉⠉⠛⣶⡀⠙⣿⣿⠀⠀⠀⠀⣿⣿⡟⢸⣿⣿⠀⢸⣿⣿⣿⠿⠿⣿⣿⣶⣿⠿⢿⣿⣿⡄
    ⣿⣿⣿⣿⣿⠙⣿⣿⣿⣿⣿⣆⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢸⣏⣀⣀⣀⣀⣀⣈⡇⢰⡟⠀⠀⠀⠀⠀⠀⣿⡀⠹⣿⣿⠀⠀⣾⣿⡟⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
    ⣿⣿⣿⣿⣿⠀⠈⢿⣿⣿⣿⣿⣷⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⢿⡇⠀⠀⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⠀⣿⡇⠀⢻⣿⣷⣰⣿⡿⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
    ⣿⣿⣿⣿⣿⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⣿⠀⠈⣿⡀⠀⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀⠀⣠⡿⠀⠀⠀⢿⣿⣿⣿⠀⠀⠀⢸⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿
    ⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠙⠁⠀⠀⠀⠀⠀⠛⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠉⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠈⠛⠛⠀⠈⠛⠛⠀⠀⠀⠘⠛⠛⠀⠀⠀⠙⠛⠋
    ⠙⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠈⢿⣿⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⡿⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ]]

      dashboard.section.header.val = vim.split(logo, '\n')
      dashboard.section.header.opts.position = 'center'
      dashboard.section.buttons.val = {
        button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        button('p', ' ' .. ' Find project', ':Telescope projects<CR>'),
        button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        button('s', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
        button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        button('q', ' ' .. ' Quit', ':qa<CR>'),
      }

      dashboard.section.footer.val = os.date()

      dashboard.section.footer.opts.hl = 'DashboardFooter'
      dashboard.section.header.opts.hl = 'DashboardHeader'
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)
    end,
  },

  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },
}
