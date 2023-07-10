
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{udesc_loe}[2023/02/07 UDESC List of Exercise Class]

\LoadClass[
12pt,
openright,
oneside,
a4paper,
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
\RequirePackage{tikz,pgf}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{physics}
%\RequirePackage{mathpazo}
%\RequirePackage[mathpazo]{flexisym}

%\RequirePackage{caption,subcaption}
\RequirePackage{soulutf8}
\RequirePackage{csquotes}
\RequirePackage[printonlyused,withpage]{acronym}
\RequirePackage{lipsum}				  % para geração de dummy text
\RequirePackage{array,booktabs,bookmark,multirow}
\RequirePackage{ragged2e}
\RequirePackage{graphicx,url}
\RequirePackage{aligned-overset}
% -------------------------------------
% Declarar novos pacotes a partir daqui
% -------------------------------------
\RequirePackage{pgfplots}
\pgfplotsset{
  width=10cm,
  compat=1.9
}
\RequirePackage{mathtools}
\RequirePackage{wrapfig}
%\RequirePackage{fancyhdr}
\RequirePackage{amssymb}
\RequirePackage{breqn}
%\RequirePackage{hyperref}
\RequirePackage{cancel}
%\RequirePackage{etoolbox}
\let\cancelorigcolor\CancelColor% Just for conveniency...
\RequirePackage{bbold}

\newcommand{\CancelTo}[3][]{%
  \ifblank{#1}{}{%
		\renewcommand{\CancelColor}{#1}%
	 }
	 \cancelto{#2}{#3}%
  }
  \RequirePackage{manyfoot}
  \DeclareNewFootnote{A}[fnsymbol]
  \DeclareNewFootnote{B}[arabic]
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
  num,
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
  \citebrackets[]
  %-----------------------------------------------%
  % Cores
  %-----------------------------------------------%
  \definecolor{coolblack}{rgb}{0.0, 0.18, 0.39}
  \definecolor{darkcerulean}{rgb}{0.03, 0.27, 0.49}
  \definecolor{darkpastelblue}{rgb}{0.47, 0.62, 0.8}
  \definecolor{indigo}{rgb}{0.0, 0.25, 0.42}
  \definecolor{azul}{HTML}{7da6cb}
  \definecolor{amarelo}{HTML}{f0b400}
  \definecolor{midnightblue}{rgb}{0.1, 0.1, 0.44}
  %-----------------------------------------------%
  % O tamanho do parágrafo é dado por:
  \setlength{\parindent}{1.3cm}
  % Controle do espaçamento entre um parágrafo e outro:
  \setlength{\parskip}{0.2cm}  % tente também 
  % ----------------------------------------------%
  % CONFIGURAÇÕES DE PACOTES
  % ----------------------------------------------%
  % Novos tipos de colunas que permita definir a largura
  \newcolumntype{R}[1]{>{\RaggedLeft\arraybackslash}p{#1}}
  \newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
  \newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
  % ----------------------------------------------%
  % CONFIGURAÇÕES DO BACKREF
  % ----------------------------------------------%
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
  % ----------------------------------------------%
  % Datas no formato dd/mm/yyyy
  % ----------------------------------------------%
  \def\mydate{\leavevmode\hbox{\twodigits\day/\twodigits\month/\the\year}}
  \def\twodigits#1{\ifnum#1<10 0\fi\the#1}
  %-----------------------------------------------%
  \makepagestyle{listaex}
  \makeoddhead{listaex}{\imprimirtitulo}{\disciplina}{Página \thepage}
  \makeheadrule{listaex}{\textwidth}{\normalrulethickness}
  % ----------------------------------------------%
  % METADADOS PDF
  % ----------------------------------------------%
  \input{src/credentials.tex}
  \hypersetup{%
	 pdftitle={\@title},%
	 pdfauthor={\@author},%
	 pdfsubject={\imprimirpreambulo},%
	 pdfkeywords={\firstkey , \secondkey , \thirdkey .},% 
	 colorlinks=true,
	 linkcolor=midnightblue,
	 citecolor=midnightblue,
	 urlcolor=black,
	 bookmarksdepth=4%
  }
  % ----------------------------------------------%
  \renewcommand{\imprimircapa}{%
	 \begin{capa}
		% ----------------------------------------------%
		% HEADER
		% ----------------------------------------------%
		\begin{center}
		  \begin{minipage}[!]{\linewidth}
			 \begin{minipage}[!]{.19\linewidth}
				\includegraphics[width=\linewidth]{assets/logo.png}           
			 \end{minipage}
			 \begin{minipage}[!]{.8\linewidth}
				\center
				\ABNTEXchapterfont\normalsize\MakeUppercase{\imprimirinstituicao}
				\par
				\vspace*{3pt}                     
				\ABNTEXchapterfont\normalsize\MakeUppercase{\centro}
				\par
				\vspace*{3pt}
				\ABNTEXchapterfont\normalsize\MakeUppercase{\departamento}
				\par
				\vspace*{3pt}           
				\ABNTEXchapterfont\normalsize\MakeUppercase{\disciplina}
			 \end{minipage}        
		  \end{minipage}
		  \par\vspace{0.5cm}
		  \rule{\textwidth}{.5pt}   
		\end{center}
		% ----------------------------------------------%
		% CAMPO DE IDENTIFICAÇÃO
		% ----------------------------------------------%
		\noindent \textbf{Aluno(a):} \imprimirautor
		\par\noindent \textbf{Professor(a):} \imprimirorientador\hfill{}\textbf{Capítulo(s) Ref.:} \capitulos  
		\par\noindent \textbf{\imprimirtipotrabalho} \numerodalista  \hfill{}\textbf{Data:} \imprimirdata\hfill{}\textbf{Fase:} \fase
		\par\noindent\rule{\textwidth}{.5pt}
		\bigskip{}
		\begin{center}
		  \ABNTEXchapterfont\Large\MakeUppercase{\imprimirtitulo}
		\end{center}
		% \noindent \textbf{Resumo:} \txtresumo
		% \par\noindent \textbf{Palavras chave:} \firstkey; \secondkey; \thirdkey; \fourthkey.
		% ----------------------------------------------%
		% SUMÁRIO
		% ----------------------------------------------%
		\pdfbookmark[0]{\contentsname}{toc}
		\tableofcontents*
		\cleardoublepage
	 \end{capa}
  }
  % ----------------------------------------------%
  % Comandos Matemáticos
  % ----------------------------------------------%
  \theoremstyle{definition}
  \newtheorem{definition}{Definição}[section]
  \newtheorem{quest}{Questão}
  \newtheorem{xca}{Problema}
  \newenvironment{prob}{%
  \par\noindent \begin{xca}}%
  {\end{xca}\noindent\rule{\textwidth}{1pt}}
  \newtheorem{sol}{Solução}
  \newtheorem{theorem}{Teorema}[section]
  \newtheorem{propos}{Proposição}[section]
  \newtheorem{corollary}{Corolário}[theorem]
  \newtheorem{lemma}[theorem]{Lema}
  % ----------------------------------------------%
  % Comandos Matemáticos
  % ----------------------------------------------%
  \DeclareMathOperator{\sen}{sen}
  \DeclareMathOperator{\senh}{senh}
  \DeclareMathOperator{\tg}{tg}
  \DeclareMathOperator{\tgh}{tgh}
  \newcommand{\parder}[2]{\frac{\partial {#1}}{\partial {#2}}}
  \newcommand{\E}{\mathrm{e}}
  % ----------------------------------------------%
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
