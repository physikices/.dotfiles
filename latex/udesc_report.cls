\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{udesc_report}[2023/02/03 UDESC Report Class]

\LoadClass[
12pt,
openright,
oneside,
a4paper,
% english,
brazil
]{abntex2}
\selectlanguage{brazil}


\RequirePackage{lmodern}		  	% Usa a fonte Latin Modern			
\RequirePackage[T1]{fontenc}		% Selecao de codigos de fonte.
\RequirePackage[utf8]{inputenc}	% Codificacao do documento (conversão automática dos acentos)
\RequirePackage{lastpage}			  % Usado pela Ficha catalográfica
\RequirePackage{indentfirst}		% Indenta o primeiro parágrafo de cada seção.
\RequirePackage{color}      	  % Controle das cores
\RequirePackage[x11names]{xcolor}
\RequirePackage{graphicx}			  % Inclusão de gráficos
\RequirePackage{microtype} 			% para melhorias de justificação
\RequirePackage{url}
\RequirePackage{breakcites}     % para quebrar citações que estouram a margem
\RequirePackage{amsmath,tikz,pgf}
%\RequirePackage{mathpazo}
%\RequirePackage[mathpazo]{flexisym}
\usepackage{color, colortbl}

\RequirePackage{subcaption}
\RequirePackage{soulutf8}
\RequirePackage{csquotes}
\RequirePackage[printonlyused,withpage]{acronym}
\RequirePackage{lipsum}				  % para geração de dummy text
\RequirePackage{array,booktabs,bookmark,multirow}
\RequirePackage{ragged2e}
\RequirePackage{graphicx,url}
% -------------------------------------
% Declarar novos pacotes a partir daqui
% -------------------------------------
\RequirePackage{pgfplots}
\pgfplotsset{
	width=10cm,
	compat=1.9
}
\RequirePackage{mathtools}
%\RequirePackage{subfig}
\RequirePackage{pdfpages}
\RequirePackage{setspace}
\RequirePackage{lettrine}
\RequirePackage{GoudyIn}
\RequirePackage{wrapfig}
\RequirePackage{fancyhdr}
\RequirePackage{amsthm}
\RequirePackage{physics}
\RequirePackage{amssymb}
\RequirePackage{hyperref}
\RequirePackage{cancel}
%\RequirePackage{etoolbox}
\RequirePackage{listofsymbols}
\RequirePackage{breqn} %necessario para usar o ambiente 'dmath'
\let\cancelorigcolor\CancelColor% Just for conveniency...

\newcommand{\CancelTo}[3][]{%
	\ifblank{#1}{}{%
			\renewcommand{\CancelColor}{#1}%
		}
		\cancelto{#2}{#3}%
	}
	\RequirePackage{manyfoot}
	\DeclareNewFootnote{A}[fnsymbol]
	\DeclareNewFootnote{B}[arabic]
	\DeclareNewFootnote{C}[alph]
	% -------------------------------
	% para resolver o problema dos apostrofos e crases no listings
	\RequirePackage{upquote,listings}
	% Para formatar unidades físicas para o padrão usado no Brasil
	\RequirePackage{physunits}
	\DeclareRobustCommand{\units@separator}{\,}
	\DeclareRobustCommand{\y}[1][ ]{\ensuremath{%
	\expandafter\units@separator\mathrm{#1ano}}}
	\DeclareRobustCommand{\Day}{\ensuremath{%
	\expandafter\units@separator\mathrm{dia}}}
	\DeclareRobustCommand{\au}{\ensuremath{%
	\expandafter\units@separator\mathrm{UA}}}
	% Pacotes de citações
	\RequirePackage[brazilian,hyperpageref]{backref}	 % Paginas com as citações na bibl
	\RequirePackage[
	alf,
	% num,
	%overcite,
	versalete,
	abnt-emphasize = bf,
	abnt-etal-list = 2,
	abnt-etal-text = it,
	abnt-and-type = &,
	abnt-last-names = abnt,
	abnt-repeated-author-omit = yes,
	bibjustif
	]{abntex2cite}	% Citações padrão ABNT
	% \citebrackets[]

	%-----------------------------------------------%
	% Espaçamentos entre linhas e parágrafos 
	%-----------------------------------------------%
	% O tamanho do parágrafo é dado por:
	\setlength{\parindent}{1.3cm}
	% Controle do espaçamento entre um parágrafo e outro:
	\setlength{\parskip}{0.2cm}  % tente também 
	%-----------------------------------------------%
	% CONFIGURAÇÕES DE PACOTES
	%-----------------------------------------------%
	% Novos tipos de colunas que permita definir a largura
	\newcolumntype{R}[1]{>{\RaggedLeft\arraybackslash}p{#1}}
	\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
	\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
	% ----------------------------------------------%
	% CONFIGURACOES LETTRINE
	% ----------------------------------------------%
	\renewcommand{\LettrineFontHook}{\color{VioletRed4}\GoudyInfamily{}}
	\setcounter{DefaultLines}{3}
	%-----------------------------------------------%
	% CONFIGURAÇÕES DO BACKREF
	%-----------------------------------------------%
	% Configurações do pacote backref
	% Usado sem a opção hyperpageref de backref
	\renewcommand{\backrefpagesname}{Citado na(s) página(s):~}
	% Texto padrão antes do número das páginas
	\renewcommand{\backref}{}
	% Define os textos da citação
	\renewcommand*{\backrefalt}[4]{
		\ifcase #1 %
			Nenhuma citação no texto.%
			\or
			Citado na página #2.%
		\else
			Citado #1 vezes nas páginas #2.%
	\fi}%
	\def\figureautorefname{Fig.}
	\def\tableautorefname{Tabela}
	\def\appendixautorefname{Apêndice}
	\def\chapterautorefname{Capítulo}
	%-----------------------------------------------%
	% Estilo de cabeçalho que só contém o número da 
	% página e uma linha
	%-----------------------------------------------%
	\makepagestyle{cabecalholimpo}
	\makeevenhead{cabecalholimpo}{\thepage}{}{} % páginas pares
	\makeoddhead{cabecalholimpo}{}{}{\thepage} % páginas ímpares
	\makeheadrule{cabecalholimpo}{\textwidth}{\normalrulethickness} % linha
	%-----------------------------------------------%
	% GERA A CAPA 
	%-----------------------------------------------%
	\input{src/credentials.tex}
	\renewcommand{\imprimircapa}{%
	\begin{capa}%
		\center
		\begin{minipage}[!]{\linewidth}
			\begin{minipage}[!]{.19\linewidth}
				\includegraphics[width=\linewidth]{assets/logo.png}           
			\end{minipage}
			\begin{minipage}[!]{.8\linewidth}
				\center
				\ABNTEXchapterfont\normalsize\MakeUppercase{\imprimirinstituicao}
				\par
				\vspace*{10pt}                     
				\ABNTEXchapterfont\normalsize\MakeUppercase{\centro}
				\par
				\vspace*{10pt}           
				\ABNTEXchapterfont\normalsize\MakeUppercase{\departamento}
			\end{minipage}        
		\end{minipage}


		\vspace{4cm}

		{\ABNTEXchapterfont\normalsize\MakeUppercase{\imprimirautor}}

		\vspace{4cm}
		\begin{center}        
			\ABNTEXchapterfont\bfseries\LARGE\imprimirtitulo
		\end{center}
		\vfill
		{\large\imprimirlocal}
		\par
		{\large\imprimirdata}

	\end{capa}
}
	
	%-----------------------------------------------%
	% GERA A FOLHA DE ROSTO 
	%-----------------------------------------------%
	\preambulo{Relatório apresentado ao curso de \curso do \centro da Universidade do Estado de Santa Catarina para aprovação da disciplina de \disciplina.}

	\renewcommand{\folhaderostocontent}{
	\begin{center}
		% \vspace*{3cm}
		% {\ABNTEXchapterfont\large\imprimirautor}
		\vfill
		\begin{center}
			% \ABNTEXchapterfont\bfseries\Large\MakeUppercase{\imprimirtitulo}
		\end{center}

		% \vspace*{\fill}

		\abntex@ifnotempty{\imprimirpreambulo}{%
			\thispagestyle{empty}
			\hspace{.45\textwidth}
			\begin{minipage}{.5\textwidth}
				\SingleSpacing
				\imprimirpreambulo

				\vspace*{.3cm}

				{\bfseries\imprimirorientadorRotulo}
				~\imprimirorientador\par

				\vspace*{.3cm}

				\abntex@ifnotempty{\imprimircoorientador}{%
					{\bfseries\imprimircoorientadorRotulo}~\imprimircoorientador%
				}%  
			\end{minipage}%
			\vspace*{\fill}
		}%

		\vspace*{2cm}
		{\large\imprimirlocal}
		% \par
		% {\large\imprimirdata}
		\vspace*{\fill}
	\end{center}
}

	

	\makeindex


	%-----------------------------------------------%
	% Configurações para inserir lista de quadros
	%-----------------------------------------------%
	\newcommand{\quadroname}{Quadro}
	\newcommand{\listofquadrosname}{Lista de quadros}
	\newfloat[chapter]{quadro}{loq}{\quadroname}
	\newlistof{listofquadros}{loq}{\listofquadrosname}
	\newlistentry{quadro}{loq}{0}
	\setfloatadjustment{quadro}{\centering}
	\counterwithout{quadro}{chapter}
	\renewcommand{\cftquadroname}{\quadroname\space} 
	\renewcommand*{\cftquadroaftersnum}{\hfill--\hfill}
	\setfloatlocations{quadro}{hbtp}



	%-----------------------------------------------%
	% Configurações para inserir código fonte
	%-----------------------------------------------%

	% Altera o nome padrão do rótulo usado no comando \autoref{}
	\renewcommand{\lstlistingname}{Código}

	% Altera o rótulo a ser usando no elemento pré-textual "Lista de código"
	\renewcommand{\lstlistlistingname}{Lista de códigos}

	% Configura a ``Lista de Códigos'' conforme as regras da ABNT (para abnTeX2)
	\begingroup\makeatletter
	\let\newcounter\@gobble\let\setcounter\@gobbletwo
	\globaldefs\@ne \let\c@loldepth\@ne
	\newlistof{listings}{lol}{\lstlistlistingname}
	\newlistentry{lstlisting}{lol}{0}
	\endgroup

	\renewcommand{\cftlstlistingaftersnum}{\hfill--\hfill}

	\let\oldlstlistoflistings\lstlistoflistings
	\renewcommand{\lstlistoflistings}{%
		\begingroup%
		\let\oldnumberline\numberline%
		\renewcommand{\numberline}{\lstlistingname\space\oldnumberline}%
		\oldlstlistoflistings%
	\endgroup}

	\colorlet{numb}{magenta!60!black}

	\lstset{ %
		aboveskip=\bigskipamount,
		backgroundcolor=\color{colBack}, 
		basicstyle=\ttfamily\footnotesize,
		keywordstyle=\color{deepblue},
		stringstyle=\color{javared},
		commentstyle=\color{javagreen},
		morecomment=[s][\color{javadocblue}]{/**}{*/},
		breakatwhitespace=false,
		breaklines=true,        
		captionpos=n,           
		columns=flexible,
		deletekeywords={...},  
		escapechar={@*},       
		extendedchars=true,    
		linewidth=0.98\linewidth,
		tab=$\to$,
		float=tbph,
		xleftmargin=10pt,
		frame=single,	         
		keepspaces=true,       
		numbers=left,    
		numbersep=5pt,   
		numberstyle=\tiny,
		rulecolor=\color{black}, 
		showspaces=false,        
		showstringspaces=false,  
		showtabs=false,          
		tabsize=2,
		title=\lstname
	}

	\lstdefinelanguage{Groovy}[]{Java}{
		keywordstyle=\color{groovyblue}\bfseries,
		stringstyle=\color{groovygreen}\ttfamily,
		keywords=[3]{each, findAll, groupBy, collect, inject, eachWithIndex},
		morekeywords={def, as, in, use},
		moredelim=[is][\textcolor{darkgray}]{\%\%}{\%\%},
		moredelim=[il][\textcolor{darkgray}]{§§}
	}
	\lstdefinelanguage{XML}{
		morestring=[s][\color{mauve}]{"}{"},
		morestring=[s][\color{black}]{>}{<},
		morecomment=[s]{<?}{?>},
		morecomment=[s][\color{dkgreen}]{<!--}{-->},
		stringstyle=\color{black},
		identifierstyle=\color{lightblue},
		keywordstyle=\color{red},
		% list your attributes here
		morekeywords={xmlns,xsi,noNamespaceSchemaLocation,type,id,x,y,source,target,version,tool,transRef,roleRef,objective,eventually}
	}
	\lstdefinelanguage{json}{
		basicstyle=\normalfont\ttfamily,
		commentstyle=\color{eclipseStrings}, % style of comment
		stringstyle=\color{eclipseKeywords}, % style of strings
		string=[s]{"}{"},
		comment=[l]{:\ "},
		morecomment=[l]{:"},
		literate=
		*{0}{{{\color{numb}0}}}{1}
		{1}{{{\color{numb}1}}}{1}
		{2}{{{\color{numb}2}}}{1}
		{3}{{{\color{numb}3}}}{1}
		{4}{{{\color{numb}4}}}{1}
		{5}{{{\color{numb}5}}}{1}
		{6}{{{\color{numb}6}}}{1}
		{7}{{{\color{numb}7}}}{1}
		{8}{{{\color{numb}8}}}{1}
		{9}{{{\color{numb}9}}}{1}
	}


	\lstdefinelanguage{docker}{
		keywords={FROM, RUN, COPY, ADD, ENTRYPOINT, CMD,  ENV, ARG, WORKDIR, EXPOSE, LABEL, USER, VOLUME, STOPSIGNAL, ONBUILD, MAINTAINER},
		keywordstyle=\color{blue}\bfseries,
		identifierstyle=\color{black},
		sensitive=false,
		comment=[l]{\#},
		% stringstyle=\color{red}\ttfamily,
		morestring=[b]',
		morestring=[b]"
	}

	\lstdefinelanguage{docker-compose}{
		keywords={image, environment, ports, container_name, ports, volumes, links},
		keywordstyle=\color{blue}\bfseries,
		identifierstyle=\color{black},
		sensitive=false,
		comment=[l]{\#},
		% stringstyle=\color{red}\ttfamily,
		morestring=[b]',
		morestring=[b]"
	}
	\lstdefinelanguage{docker-compose-2}{
		keywords={version, volumes, services},
		keywordstyle=\color{blue}\bfseries,
		keywords=[2]{image, environment, ports, container_name, ports, links, build},
		keywordstyle=[2]\color{olive}\bfseries,
		identifierstyle=\color{black},
		sensitive=false,
		comment=[l]{\#},
		commentstyle=\color{purple}\ttfamily,
		stringstyle=\color{red}\ttfamily,
		morestring=[b]',
		morestring=[b]"
	}

	% Permitindo caracteres acentuados dentro do ambiente lstlisting
	\lstset{%
		inputencoding=utf8,
		extendedchars=true,
		literate=%
		{é}{{\'{e}}}1
		{è}{{\`{e}}}1
		{ê}{{\^{e}}}1
		{ë}{{\¨{e}}}1
		{É}{{\'{E}}}1
		{Ê}{{\^{E}}}1
		{û}{{\^{u}}}1
		{ù}{{\`{u}}}1
		{â}{{\^{a}}}1
		{à}{{\`{a}}}1
		{á}{{\'{a}}}1
		{ã}{{\~{a}}}1
		{Á}{{\'{A}}}1
		{Â}{{\^{A}}}1
		{Ã}{{\~{A}}}1
		{ç}{{\c{c}}}1
		{Ç}{{\c{C}}}1
		{õ}{{\~{o}}}1
		{ó}{{\'{o}}}1
		{ú}{{\'{u}}}1
		{Ú}{{\'{U}}}1
		{ô}{{\^{o}}}1
		{Õ}{{\~{O}}}1
		{Ó}{{\'{O}}}1
		{Ô}{{\^{O}}}1
		{î}{{\^{i}}}1
		{Î}{{\^{I}}}1
		{í}{{\'{i}}}1
		{Í}{{\~{Í}}}1
	}

	\lstdefinestyle{shell}{language=csh,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{shellp}{language=csh,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{php}{language=php,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{phpp}{language=php,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{ansic}{language=c,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{ansicp}{language=c,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{cpp}{language=C++,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{cppp}{language=C++,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{docker}{language=docker,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{docker-compose}{language=docker-compose,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{docker-compose2}{language=docker-compose2,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{json}{language=json,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{java}{language=java,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{javap}{language=java,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{matlab}{language=matlab,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{matlabp}{language=matlab,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{python}{language=python,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{pythonp}{language=python,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{xml}{language=XML,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{xmlp}{language=XML,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{sql}{language=sql,basicstyle=\ttfamily\footnotesize}
	\lstdefinestyle{sqlp}{language=sql,basicstyle=\ttfamily\scriptsize}
	\lstdefinestyle{groovy}{language=Groovy,basicstyle=\ttfamily\footnotesize}

	\newcommand{\groovy}{\lstset{style=Groovy}}
	\newcommand{\cpp}{\lstset{style=cpp}}
	\newcommand{\cppp}{\lstset{style=cppp}}
	\newcommand{\ansic}{\lstset{style=ansic}}
	\newcommand{\ansicp}{\lstset{style=ansicp}}
	\newcommand{\json}{\lstset{style=json}}
	\newcommand{\java}{\lstset{style=java}}
	\newcommand{\javap}{\lstset{style=javap}}
	\newcommand{\sql}{\lstset{style=sql}}
	\newcommand{\sqlp}{\lstset{style=sqlp}}
	\newcommand{\xml}{\lstset{style=xml}}
	\newcommand{\xmlp}{\lstset{style=xmlp}}
	\newcommand{\python}{\lstset{style=python}}
	\newcommand{\pythonp}{\lstset{style=pythonp}}
	\newcommand{\csh}{\lstset{style=shell}}
	\newcommand{\cshp}{\lstset{style=shellp}}
	\newcommand{\shell}{\lstset{style=shell}}
	\newcommand{\shellp}{\lstset{style=shellp}}



	\newcommand{\includecode}[4][c]{\lstinputlisting[captionpos=t,caption=#3, label=#2,escapechar={@*}, style=#1]{#4}}

	% ---------------------------------
	% Ambiente de Teoremas e Exercícios
	% ---------------------------------
	\theoremstyle{definition}
	\newtheorem{definition}{Definição}[section]
	\newtheorem{quest}{Questão}
	\newtheorem{xca}{Problema}
	\newenvironment{prob}{%
	\par\noindent \begin{xca}}%
	{\end{xca}\noindent\rule{\textwidth}{1pt}}
	\newtheorem{sol}{Solução}
	\newtheorem{theorem}{Teorema}[section]
	\newtheorem{corollary}{Corolário}[theorem]
	\newtheorem{lemma}[theorem]{Lema}
	% ---------------------------------
	% ---------------------------
	% Alguns comandos Matemáticos
	% ---------------------------
	\DeclareMathOperator{\sen}{sen}
	\DeclareMathOperator{\senh}{senh}
	\DeclareMathOperator{\tg}{tg}
	\DeclareMathOperator{\tgh}{tgh}
	\newcommand{\parder}[2]{\frac{\partial {#1}}{\partial {#2}}}
	\newcommand{\E}{\mathrm{e}}
	% ---------------------------
	% -------------------------
	% Datas no formato dd/mm/yyyy
	% -------------------------
	\def\mydate{\leavevmode\hbox{\twodigits\day/\twodigits\month/\the\year}}
	\def\twodigits#1{\ifnum#1<10 0\fi\the#1}
	% -------------------------

	\makeatletter
	\providecommand*{\dif}%
	{\@ifnextchar^{\DIfF}{\DIfF^{}}}
	\def\DIfF^#1{%
		\mathop{\mathrm{\mathstrut d}}%
		\nolimits^{#1}\gobblespace
	}
	\def\gobblespace{%
	\futurelet\diffarg\opspace}
	\def\opspace{%
		\let\DiffSpace\!%
		\ifx\diffarg(%
			\let\DiffSpace\relax
		\else
			\ifx\diffarg\[%
					\let\DiffSpace\relax
				\else
					\ifx\diffarg\{%
							\let\DiffSpace\relax
					\fi\fi\fi\DiffSpace}
					\makeatother




