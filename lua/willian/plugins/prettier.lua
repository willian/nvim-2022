local status_ok, prettier = pcall(require, 'prettier')
if not status_ok then
  return
end

prettier.setup({
  bin = 'prettierd',
  cli_options = {
    arrow_parens = 'avoid',
    bracket_spacing = false,
    jsx_bracket_same_line = false,
    print_width = 100,
    prose_wrap = 'always',
    require_config = true,
    semi = false,
    single_quote = true,
    tab_width = 2,
    trailing_comma = 'all',
    use_tabs = false,
  },
})
