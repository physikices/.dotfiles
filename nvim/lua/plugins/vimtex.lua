return {
  "lervag/vimtex",

  lazy = true,
  ft = { "tex", "bib" },
  config = function()
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    vim.g.vimtex_view_general_viewer = "mupdf"
    vim.g.vimtex_view_method = "mupdf"
    vim.g.vimtex_view_forward_search_on_start = true

    vim.g.vimtex_toc_config = {
      mode = 1,
      fold_enable = 0,
      hide_line_numbers = 1,
      resize = 0,
      refresh_always = 1,
      show_help = 0,
      show_numbers = 1,
      split_pos = 'vert leftabove',
      split_width = 30,
      tocdeth = 3,
      indent_levels = 1,
      todo_sorted = 1,
    }

    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull',
      'Overfull',
      'LaTeX Font Warning',
      'Package siunitx Warning'
    }
  end,
}
