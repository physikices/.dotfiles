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

local snippets, autosnippets = {}, {}

---------------
-- Templates --
---------------
local math_template = s("mtemp", fmt([[
\documentclass[12pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath, amsthm, amssymb, graphicx, multicol, array, mathtools, mdframed}
\usepackage{import, pdfpages, transparent, xcolor}
\newcommand{\inkfig}[2][1]{\def\svgwidth{#1\columnwidth} \import{./img/}{#2.pdf_tex}}
\newcommand{\br}[1]{\left(#1\right)}
\newcommand{\sbr}[1]{\left[#1\right]}
\newcommand{\cbr}[1]{\left\\{#1\right\\}}
\newcommand{\norm}[1]{\left\|#1\right\|}
\newcommand{\abs}[1]{\left|#1\right|}
\newcommand{\st}{\text{ s.t. }}
\newcommand{\tand}{\text{ and }}
\newcommand{\tor}{\text{ or }}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\DS}{\displaystyle{}}
\renewcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\pagestyle{empty}
\title{<>}
\author{<>}
\date{<>}
\begin{document}
    <>
\end{document}
]], {
    i(1, "TITLE"),
    i(2, "Hisbaan Noorani"),
    i(3, "DATE"),
    i(0)
}, { delimiters = "<>" }
))
table.insert(snippets, math_template)

return snippets, autosnippets

