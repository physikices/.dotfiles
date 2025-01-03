local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")



local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
	{
		-- ANNOTATE (custom command for annotating equation derivations)
		s({trig = "ann", snippetType="autosnippet"},
			fmta(
				[[
				\annotate{<>}{<>}
				]],
				{
					i(1),
					d(2, get_visual),
				}
			)
		),
		-- *REFERENCE
		s({trig = " RR", snippetType="autosnippet", wordTrig=false},
			fmta(
				[[
				~\ref{<>}
				]],
				{
					d(1, get_visual),
				}
			)
		),
		-- DOCUMENTCLASS
		s({trig = "dcc", snippetType="autosnippet"},
			fmta(
				[[
				\documentclass[<>]{<>}
				]],
				{
					i(1, "a4paper"),
					i(2, "article"),
				}
			),
			{ condition = line_begin }
		),
		-- *USE A LATEX PACKAGE
		s({trig = "pack", snippetType="autosnippet"},
			fmta(
				[[
				\usepackage{<>}
				]],
				{
					d(1, get_visual),
				}
			),
			{ condition = line_begin }
		),
		-- INPUT a LaTeX file
		s({trig = "inn", snippetType="autosnippet"},
			fmta(
				[[
				\input{<><>}
				]],
				{
					i(1, "~/dotfiles/config/latex/templates/"),
					i(2)
				}
			),
			{ condition = line_begin }
		),
		-- *LABEL
		s({trig = "lbl", snippetType="autosnippet"},
			fmta(
				[[
				\label{<>}
				]],
				{
					d(1, get_visual),
				}
			)
		),
		-- *HPHANTOM
		s({trig = "hpp", snippetType="autosnippet"},
			fmta(
				[[
				\hphantom{<>}
				]],
				{
					d(1, get_visual),
				}
			)
		),
		-- *TODO List
		s({trig = "TODOO", snippetType="autosnippet"},
			fmta(
				[[\TODO{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		s({trig="nc"},
			fmta(
				[[\newcommand{<>}{<>}]],
				{
					i(1),
					i(2)
				}
			),
			{condition = line_begin}
		),
		s({trig="sii", snippetType="autosnippet"},
			fmta(
				[[\si{<>}]],
				{
					i(1),
				}
			)
		),
		s({trig="SI"},
			fmta(
				[[\SI{<>}{<>}]],
				{
					i(1),
					i(2)
				}
			)
		),
		s({trig="url"},
			fmta(
				[[\url{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		-- VSPACE
		s({trig="vs"},
			fmta(
				[[\vspace{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		-- SECTION
		s({trig="h1", snippetType="autosnippet"},
			fmta(
				[[\section{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		-- SUBSECTION
		s({trig="h2", snippetType="autosnippet"},
			fmta(
				[[\subsection{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		-- SUBSUBSECTION
		s({trig="h3", snippetType="autosnippet"},
			fmta(
				[[\subsubsection{<>}]],
				{
					d(1, get_visual),
				}
			)
		),
		-- End Refactoring --
}

