local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets, autosnippets = {}, {}
---------------
-- Templates --
---------------

local beamer_template = s("tbmer", fmt([[
 \documentclass[xcolor=dvipsnames]{beamer}

 \usepackage[brazil]{babel}
 \usepackage[utf8]{inputenc}
 \usefonttheme[onlymath]{serif}

 \usetheme{Madrid}
 \usepackage{../style/beamercolorthemestd}
 \useoutertheme{miniframes} %Alternatively: miniframes, infolines, split
 \useinnertheme{circles}

  \title{<>}
  \subtitle{<>}
  \author[<>]{<>}
  \date{<>}
  \institute[UDESC]{Universidade do Estado de Santa Catarina\\Centro de Ciências Tecnológicas\\Campus Joinville}

\begin{document}

  \begin{frame}
	 \titlepage
  \end{frame}

  \begin{frame}
	 \frametitle{Sumário}
	 \tableofcontents[pausesections]
  \end{frame}

  % Presentation structure
  \section{Problem statement}
  \section{Existing results}
		\subsection{Method 1}
		\subsection{Method 2}
		\subsection{Method 3}
  \section{Comparative study}
  \section*{References}

	 <>

\end{document}
]], {
	 i(1, "título"),
	 i(2, "subtítulo"),
	 i(3, "disciplina"),
	 i(4, "autor"),
	 i(5,"\\today"),
	 i(0)
  }, { delimiters = "<>" }
))
table.insert(snippets, beamer_template)

--------------
-- Snippets --
--------------
local normal_frame =s("nfrm", fmt([[
 \begin{frame}{<>}
	\framesubtitle{<>}
		<>
	\end{frame}
]],{
	 i(1,"title frame"),
	 i(2,"subtitle frame"),
	 i(0)
  },{ delimiters = "<>" }
))
table.insert(snippets, normal_frame)


return snippets, autosnippets
