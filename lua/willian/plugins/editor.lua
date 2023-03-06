return {
  -- file explorer
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toogle explorer' },
    },
    opts = function()
      local nvim_tree_config = require('nvim-tree.config')
      local tree_cb = nvim_tree_config.nvim_tree_callback

      return {
        filters = {
          dotfiles = true,
        },
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
              git = false,
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
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
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
              {
                key = { '+', '=' },
                cb = '<CMD>lua require("nvim-tree").resize("+10")<CR>',
              },
              {
                key = { '-' },
                cb = '<CMD>lua require("nvim-tree").resize("-10")<CR>',
              },
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
      }
    end,
    config = function(_, opts)
      -- import nvim-tree plugin safely
      local nvim_tree = require('nvim-tree')

      -- recommended settings from nvim-tree documentation
      vim.g.loaded = 1
      vim.g.loaded_netrwPlugin = 1

      nvim_tree.setup(opts)
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      {
        '<C-p>',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find files within current working directory, respects .gitignore',
      },
      {
        '<leader>,',
        '<cmd>Telescope buffers show_all_buffers=true<cr>',
        desc = 'Switch Buffer',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Find in Files (Grep)',
      },
      {
        '<leader>:',
        '<cmd>Telescope command_history<cr>',
        desc = 'Command History',
      },
      {
        '<leader><space>',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find Files (root dir)',
      },
      -- find
      {
        '<leader>fb',
        '<cmd>Telescope buffers<cr>',
        desc = 'Buffers',
      },
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find Files (root dir)',
      },
      {
        '<leader>fF',
        function()
          require('telescope.builtin').find_files({ cwd = false })
        end,
        desc = 'Find Files (cwd)',
      },
      {
        '<leader>fr',
        '<cmd>Telescope oldfiles<cr>',
        desc = 'Recent',
      },
      {
        '<leader>fs',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Find text',
      },
      -- git
      {
        '<leader>gc',
        '<cmd>Telescope git_commits<CR>',
        desc = 'commits',
      },
      {
        '<leader>gs',
        '<cmd>Telescope git_status<CR>',
        desc = 'status',
      },
      -- search
      {
        '<leader>sa',
        '<cmd>Telescope autocommands<cr>',
        desc = 'Auto Commands',
      },
      {
        '<leader>sb',
        '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        desc = 'Buffer',
      },
      {
        '<leader>sc',
        '<cmd>Telescope command_history<cr>',
        desc = 'Command History',
      },
      {
        '<leader>sC',
        '<cmd>Telescope commands<cr>',
        desc = 'Commands',
      },
      {
        '<leader>sd',
        '<cmd>Telescope diagnostics<cr>',
        desc = 'Diagnostics',
      },
      {
        '<leader>sg',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Grep (root dir)',
      },
      {
        '<leader>sG',
        function()
          require('telescope.builtin').live_grep({ cwd = false })
        end,
        desc = 'Grep (cwd)',
      },
      {
        '<leader>sh',
        '<cmd>Telescope help_tags<cr>',
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        '<cmd>Telescope highlights<cr>',
        desc = 'Search Highlight Groups',
      },
      {
        '<leader>sk',
        '<cmd>Telescope keymaps<cr>',
        desc = 'Key Maps',
      },
      {
        '<leader>sM',
        '<cmd>Telescope man_pages<cr>',
        desc = 'Man Pages',
      },
      {
        '<leader>sm',
        '<cmd>Telescope marks<cr>',
        desc = 'Jump to Mark',
      },
      {
        '<leader>so',
        '<cmd>Telescope vim_options<cr>',
        desc = 'Options',
      },
      {
        '<leader>sR',
        '<cmd>Telescope resume<cr>',
        desc = 'Resume',
      },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'Word (root dir)',
      },
      {
        '<leader>sW',
        function()
          require('telescope.builtin').grep_string({ cwd = false })
        end,
        desc = 'Word (cwd)',
      },
      {
        '<leader>uC',
        function()
          require('telescope.builtin').colorscheme({ enable_preview = true })
        end,
        desc = 'Colorscheme with preview',
      },
      {
        '<leader>ss',
        function()
          require('telescope.builtin').lsp_document_symbols({
            symbols = {
              'Class',
              'Function',
              'Method',
              'Constructor',
              'Interface',
              'Module',
              'Struct',
              'Trait',
              'Field',
              'Property',
            },
          })
        end,
        desc = 'Goto Symbol',
      },
      {
        '<leader>sS',
        function()
          require('telescope.builtin').lsp_workspace_symbols({
            symbols = {
              'Class',
              'Function',
              'Method',
              'Constructor',
              'Interface',
              'Module',
              'Struct',
              'Trait',
              'Field',
              'Property',
            },
          })
        end,
        desc = 'Goto Symbol (Workspace)',
      },
    },
    opts = {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        mappings = {
          i = {
            ['<c-t>'] = function(...)
              return require('trouble.providers.telescope').open_with_trouble(...)
            end,
            ['<a-i>'] = function()
              require('telescope.builtin').find_files({ no_ignore = true })
            end,
            ['<a-h>'] = function()
              require('telescope.builtin').find_files({ hidden = true })
            end,
            ['<C-Down>'] = function(...)
              return require('telescope.actions').cycle_history_next(...)
            end,
            ['<C-Up>'] = function(...)
              return require('telescope.actions').cycle_history_prev(...)
            end,
            ['<C-f>'] = function(...)
              return require('telescope.actions').preview_scrolling_down(...)
            end,
            ['<C-b>'] = function(...)
              return require('telescope.actions').preview_scrolling_up(...)
            end,
          },
          n = {
            ['q'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
      },
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    'ggandor/flit.nvim',
    keys = function()
      local ret = {}
      for _, key in ipairs({ 'f', 'F', 't', 'T' }) do
        ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = 'nx' },
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      local keymaps = {
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['s'] = { name = '+surround' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>l'] = { name = '+lsp' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>t'] = { name = '+terminal' },
        ['<leader>u'] = { name = '+ui' },
        ['<leader>w'] = { name = '+windows' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
      }
      wk.register(keymaps)
    end,
  },

  -- git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = {
          hl = 'GitSignsAdd',
          text = '▎',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        change = {
          hl = 'GitSignsChange',
          text = '▎',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '契',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '契',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsChange',
          text = '▎',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
    },
  },
  {
    'f-person/git-blame.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_message_template = '<summary> • <date> • <author>'
      vim.g.gitblame_highlight_group = 'LineNr'
    end,
  },

  -- references
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { delay = 200 },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },

  -- buffer remove
  {
    'echasnovski/mini.bufremove',
    -- stylua: ignore
    keys = {
      { "<S-q>",      function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        '<leader>xx',
        '<cmd>TroubleToggle document_diagnostics<cr>',
        desc = 'Document Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>TroubleToggle workspace_diagnostics<cr>',
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>TroubleToggle loclist<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>TroubleToggle quickfix<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },

  -- todo comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
  },

  -- peeks lines of the buffer in non-obtrusive way
  {
    'nacro90/numb.nvim',
    opts = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    },
  },

  -- persist and toggle multiple terminals during an editing session
  {
    'akinsho/toggleterm.nvim',
    keys = {
      { '<leader>t1', '<cmd>1ToggleTerm<CR>', desc = 'Toggle terminal #1' },
      { '<leader>t2', '<cmd>2ToggleTerm<CR>', desc = 'Toggle terminal #2' },
      { '<leader>t3', '<cmd>3ToggleTerm<CR>', desc = 'Toggle terminal #3' },
      { '<leader>t4', '<cmd>4ToggleTerm<CR>', desc = 'Toggle terminal #4' },
      {
        '<leader>gg',
        function()
          _LAZYGIT_TOGGLE()
        end,
        desc = 'Toggle lazygit',
      },
    },
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    },
    config = function(_, opts)
      local toggleterm = require('toggleterm')

      toggleterm.setup(opts)

      function _G.set_terminal_keymaps()
        local keymap_opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], keymap_opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        float_opts = {
          border = 'none',
          width = 100000,
          height = 100000,
        },
        on_open = function(_)
          vim.cmd('startinsert!')
          -- vim.cmd "set laststatus=0"
        end,
        on_close = function(_)
          -- vim.cmd "set laststatus=3"
        end,
        count = 99,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
    end,
  },
}
