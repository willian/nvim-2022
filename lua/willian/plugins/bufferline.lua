---@diagnostic disable: assign-type-mismatch
local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  return
end

local use_icons = true

local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function diagnostics_indicator(num, _, diagnostics, _)
  local table_result = {}
  local result = ''
  local symbols = {
    error = ' ',
    warning = ' ',
    info = ' ',
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

bufferline.setup({
  options = {
    numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = { icon = '▎', style = 'icon' },
    buffer_close_icon = ' ',
    modified_icon = '● ',
    close_icon = ' ',
    left_trunc_marker = ' ',
    right_trunc_marker = ' ',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the bufferline so use this at your discretion knowing
    --that it has some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --   -- remove extension from markdown files for example
    --   if buf.name:match('%.md') then
    --     return vim.fn.fnamemodify(buf.name, ':t:r')
    --   end
    -- end,
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = 'nvim_lsp', -- | "coc" | false
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = custom_filter,
    offsets = {
      {
        filetype = 'NvimTree',
        text = '',
        padding = 1,
      },
      {
        filetype = 'packer',
        text = 'Packer',
        highlight = 'PanelHeading',
        padding = 1,
      },
    },
    show_buffer_icons = use_icons,
    show_buffer_close_icons = use_icons,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  },
  highlights = {
    background = {
      italic = true,
    },
    buffer_selected = {
      bold = true,
    },
  },
})
