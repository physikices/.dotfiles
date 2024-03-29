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

local get_visual = function(args, parent)
	if (#parent.snippet.env.SELECT_RAW > 0) then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else  -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
	{
		-- GENERIC ENVIRONMENT
		s({trig="new", snippetType="autosnippet"},
			fmta(
				[[
				\begin{<>}
						<>
				\end{<>}
				]],
				{
					i(1),
					d(2, get_visual),
				rep(1),
				}
			),
			{condition = line_begin}
		),
		-- ENVIRONMENT WITH ONE EXTRA ARGUMENT
		s({trig="n2", snippetType="autosnippet"},
			fmta(
				[[
				\begin{<>}{<>}
						<>
				\end{<>}
				]],
				{
					i(1),
					i(2),
					d(3, get_visual),
					rep(1),
				}
			),
			{ condition = line_begin }
		),
		-- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
		s({trig="n3", snippetType="autosnippet"},
			fmta(
				[[
				\begin{<>}{<>}{<>}
						<>
				\end{<>}
				]],
				{
					i(1),
					i(2),
					i(3),
					d(4, get_visual),
				rep(1),
				}
			),
			{ condition = line_begin }
		),
		-- TOPIC ENVIRONMENT (my custom tcbtheorem environment)
		s({trig="nt", snippetType="autosnippet"},
			fmta(
				[[
				\begin{topic}{<>}{<>}
						<>
				\end{topic}
				]],
				{
					i(1),
					i(2),
					d(3, get_visual),
				}
			),
			{ condition = line_begin }
		),
		-- EQUATION
		s({trig="nn", snippetType="autosnippet"},
			fmta(
				[[
				\begin{equation*}
						<>
				\end{equation*}
				]],
				{
					i(1),
				}
			),
			{ condition = line_begin }
		),
		-- SPLIT EQUATION
		s({trig="ss", snippetType="autosnippet"},
			fmta(
				[[
				\begin{equation*}
						\begin{split}
								<>
						\end{split}
				\end{equation*}
				]],
				{
					d(1, get_visual),
				}
			),
			{ condition = line_begin }
		),
		-- ALIGN
		s({trig="all", snippetType="autosnippet"},
			fmta(
				[[
				\begin{align*}
						<>
				\end{align*}
				]],
				{
					i(1),
				}
			),
			{condition = line_begin}
		),
		-- ITEMIZE
		s({trig="itt", snippetType="autosnippet"},
			fmta(
				[[
				\begin{itemize}
						\item <>
				\end{itemize}
				]],
				{
					i(0),
				}
			),
			{condition = line_begin}
		),
		-- ENUMERATE
		s({trig="enn", snippetType="autosnippet"},
			fmta(
				[[
				\begin{enumerate}[label=\alph *)]
						\item <>
				\end{enumerate}
				]],
				{
					i(0),
				}
			)
		),
		-- INLINE MATH
		s({trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>$<>$",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- INLINE MATH ON NEW LINE
		s({trig = "^mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"$<>$",
				{
					i(1),
		})),
		-- FIGURE
		s({trig = "fig"},
			fmta(
				[[
				\begin{figure}[htb!]
					\centering
					\includegraphics[width=<>\linewidth]{<>}
					\caption{<>}
					\label{fig:<>}
				\end{figure}
				]],
				{
					i(1),
					i(2),
					i(3),
					i(4),
				}
			),
			{ condition = line_begin }
		),
		-- SUBEQUATIONS
		s({trig="sbe", snippetType="autosnippet"},
			fmta(
				[[
				\begin{subequations}
						\begin{align}
								<>\label{eq:<>}\\
								<>\label{eq:<>}
						\end{align}
				\end{subequations}
				]],
				{
					i(1),
					i(2),
					i(3),
					d(4, get_visual),
				}
			),
			{ condition = line_begin }
		),
		-- DMATH
		s({trig="dmt", snippetType="autosnippet"},
			fmta(
				[[
				\begin{dmath*}
						<>\condition{<> $\displaystyle{<>}$}
				\end{dmath*}
				]],
				{
					i(1),
					i(2),
					i(3),
				}
			),
			{condition = line_begin}
		),
		-- WRAPFIGURE
		s({trig = "wfig"},
			fmta(
				[[
				\setlength\intextsep{0pt}
				\begin{wrapfigure}[9]{<>}{0.5\textwidth}
					\centering
					\includegraphics[width=.45\textwidth]{assets/<>}
					\caption{<>}
					\label{fig:<>}
				\end{wrapfigure}
				]],
				{
					c(1,{t("r"),t("l")}),
					i(2),
					i(3),
					i(4),
				}
			),
			{ condition = line_begin }
		),
		--
		s({trig="bcs", snippetType="autosnippet"},
			fmta(
				[[
				\begin{eqnarray*}
					<> =
					\begin{cases}
					  <>, &\text{se $<>$}\\
					  <>, &\text{se $<>$}\\
					\end{cases}
				\end{eqnarray*}
				]],
				{
					i(1),
					i(2),
					i(3),
					i(4),
					i(5),
				}
			),
			{ condition = line_begin }
		),
		--
		-- End Refactoring --
}

