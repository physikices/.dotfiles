

vim.g.vimtex_view_method = "mupdf"
vim.g.vimtex_view_general_viewer = "mupdf"
vim.g.vimtex_view_forward_search_on_start = false
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
-- Latex warnings to ignore [TESTAR]
vim.g.vimtex_quickfix_ignore_filters = {
	-- "Command terminated with space",
	-- "LaTeX Font Warning: Font shape",
	-- "Package caption Warning: The option",
	-- [[Underfull \\hbox (badness [0-9]*) in]],
	-- "Package enumitem Warning: Negative labelwidth",
	-- [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
	-- [[Package caption Warning: Unused \\captionsetup]],
	-- "Package typearea Warning: Bad type area settings!",
	-- [[Package fancyhdr Warning: \\headheight is too small]],
	-- [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
	-- "Package hyperref Warning: Token not allowed in a PDF string",
	-- [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
}

--vim.g.vimtex_complete_bib_menu_format = '[<type>] <author> (<year>), "<title>"'



