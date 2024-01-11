local present, indent_blankline = pcall(require, "ibl")
if not present then return end

indent_blankline.setup {}
-- indent_blankline.setup {
-- 	char = "▏",
-- 	char_blankline = " ",
-- 	filetype_exclude = { "help", "terminal", "packer", "lspinfo", "TelescopePrompt", "TelescopeResults", "FALLBACK" },
-- 	buftype_exclude = { "terminal" },
-- 	show_trailing_blankline_indent = false,
-- 	show_first_indent_level = false,
-- 	show_end_of_line = false,
-- 	-- char_highlight_list = {
-- 	-- 	"IndentBlanklineIndent1",
-- 	-- 	"IndentBlanklineIndent2",
-- 	-- 	"IndentBlanklineIndent3",
-- 	-- 	"IndentBlanklineIndent4",
-- 	-- 	"IndentBlanklineIndent5",
-- 	-- 	"IndentBlanklineIndent6",
-- 	-- },
-- }
