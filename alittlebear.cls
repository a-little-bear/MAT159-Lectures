%Template for alittlebear.cls
%\documentclass[11pt, brown, sepia, 1in]{alittlebear}
%\def\course{}
%\def\headername{}
%\def\name{}
%\def\email{}
%\def\info{}
%\def\logo{}
%\begin{document}
%\coverpage[clsfiles/stars]
%\end{document}



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{alittlebear}[2024/02/18 alittlebear]

%settings
\def\filename{\headername} %name of file
\def\skippar{5pt} %skip between paragraphs
\def\indentpar{0pt} %indent of paragraph
\def\thmstyle{definition} %asmthm theorme style
\def\defaultlanguage{python}

\newcommand{\thmopacity}{0.8} %opacity of theorem box, default: night mode
\newcommand{\nightmodebackground}{clsfiles/nightsky} %background of night mode





% Options
\RequirePackage{silence}
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\SetupKeyvalOptions{family=ALB,prefix=ALB@,setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{ALB}{#1}}
\DeclareStringOption[blue]{color}
\DeclareVoidOption{green}{\ekv{color=green}}
\DeclareVoidOption{cyan}{\ekv{color=cyan}}
\DeclareVoidOption{blue}{\ekv{color=blue}}
\DeclareVoidOption{sakura}{\ekv{color=sakura}}
\DeclareVoidOption{black}{\ekv{color=black}}
\DeclareVoidOption{brown}{\ekv{color=brown}}
\DeclareVoidOption{white}{\ekv{color=white}}
% margin
\DeclareStringOption[0.5in]{marg}
\DeclareVoidOption{1in}{\ekv{marg=1in}}
\DeclareVoidOption{0.5in}{\ekv{marg=0.5in}}
% green / white / yellow
\DeclareStringOption{mode}
\DeclareVoidOption{geye}{\ekv{mode=geye}}
\DeclareVoidOption{hazy}{\ekv{mode=hazy}}
\DeclareVoidOption{sepia}{\ekv{mode=sepia}}
\DeclareVoidOption{night}{\ekv{mode=night}}
\DeclareStringOption[11pt]{fontsize}
\DeclareVoidOption{10pt}{\ekv{fontsize=10pt}}
\DeclareVoidOption{11pt}{\ekv{fontsize=11pt}}
\DeclareVoidOption{12pt}{\ekv{fontsize=12pt}}
\DeclareDefaultOption{
    \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyvalOptions*\relax
\LoadClass{article}


\ifdefstring{\ALB@marg}{0.5in}{
    \RequirePackage[margin=0.5in, footskip=.5pt]{geometry}
}{\relax}
\ifdefstring{\ALB@marg}{1in}{
    \RequirePackage[margin=1in, footskip=.5pt]{geometry}
}{\relax}



\RequirePackage{lmodern, enumitem, needspace} % dynamic line breaking
\RequirePackage{ifthen}
\RequirePackage{amsmath, amssymb, amsthm, amscd, graphicx}
\RequirePackage{mathtools} % multlined environment inside align
\RequirePackage{microtype} % text spacing margin etc
\RequirePackage{mathrsfs} % for mathscr
\RequirePackage{listings, accsupp}
\RequirePackage{setspace}
\RequirePackage{multicol}

\RequirePackage{footnote}
\newcommand{\extractfootnote}[1]{
    \BeforeBeginEnvironment{#1}{\savenotes}
    \AfterEndEnvironment{#1}{\spewnotes}
}

\RequirePackage{silence}
%Disable all warnings issued by latex starting with "You have..."
\WarningFilter{latex}{You have requested package}
\WarningFilter{fancyhdr}{\footskip is too small}


\newcommand\mailto[1]{\href{mailto:#1}{\nolinkurl{#1}}}

%Header and footer
\RequirePackage{xcolor, fancyhdr, lastpage, fourier-orns, pgfornament}
\def\headerfootercolor{\color{ecolor!80!black}} %header & footer color
%header line
\RequirePackage{skak}
\renewcommand{\headrule}{
        \ifcsdef{headername}{
            \headerfootercolor\hrulefill
            \raisebox{-2.1pt}{\footnotesize\quad\floweroneleft\quad \headername\quad\floweroneright\quad}\hrulefill
        }{
            \headerfootercolor\hrulefill
            \raisebox{-2.1pt}{\footnotesize\quad\WhiteKnightOnWhite\WhiteQueenOnWhite\WhitePawnOnWhite\WhiteBishopOnWhite\WhiteRookOnWhite\quad}\hrulefill
        }
    }
    %{\color{brown}\begin{center}\pgfornament[width=7cm]{88}\end{center}}
%footer line
\renewcommand{\footrule}{
    \headerfootercolor\hrulefill
    \raisebox{-2.1pt}{\quad\decofourleft\leafSE\quad\footnotesize Page \thepage\ of \pageref{LastPage}\quad\leafSW\decofourright\quad}\hrulefill}

\newcommand*{\coverpage}[1][clsfiles/stars]{
    \newgeometry{margin = 0in}
    \vfill
    \begin{titlepage}
        \includegraphics[width=\paperwidth]{#1}
        \vskip-5pt

        \setlength{\fboxsep}{0pt}
        \ifdefstring{\ALB@mode}{night}{
            \colorbox{black}{\makebox[\linewidth][c]{\shortstack[c]{\vspace{0.3in}}}}
        }{
            \colorbox{\ALB@color}{\makebox[\linewidth][c]{\shortstack[c]{\vspace{0.3in}}}}
        }


        % Title
        \color{ecolor}\rule{\linewidth}{0.3mm} \\[0.4cm]
        \ifcsdef{course}{\centering \huge \bfseries \color{ecolor} \course \\[0.5cm] }{}
        \ifcsdef{headername}{\centering \huge \bfseries \color{ecolor} \headername \\[0.5cm] }{}
        \color{ecolor}\rule{\linewidth}{0.3mm} \\[1cm]

        \indenv[3]{
            \begin{minipage}{0.4\textwidth}
                \ifcsdef{name}{\large\tbf{Author:} \name \\[0.5cm]}{}
                \ifcsdef{email}{\large\tbf{Email:} \mailto{\email} \\[0.5cm]}{}
                \ifcsdef{date}{\large\tbf{Date:} \today \\[0.5cm]}{}
                \ifcsdef{info}{\large\tbf{Info:} \info \\[0.5cm]}{}
            \end{minipage}
            \begin{minipage}{0.1\textwidth}
                \hfill
            \end{minipage}
            \begin{minipage}{0.5\textwidth}
                \ifcsdef{logo}{\includegraphics[width=\textwidth/2]{\logo}}{\includegraphics[width=\textwidth/2]{clsfiles/uoft}}
            \end{minipage}
        }
    \end{titlepage}
    \par
    \restoregeometry
    \np
    \pagestyle{style}
}
% later page style
\fancypagestyle{style}{
    \fancyhf{}
    \ifcsdef{course}{\lhead{\headerfootercolor\course}}{}
    \ifcsdef{name}{\rhead{\headerfootercolor\name}}{}
    
    %\chead{\today}
    \setlength{\headheight}{35pt}}
% declare first page style
% \AtBeginDocument{\thispagestyle{firstpagestyle}}





% listings
\RequirePackage{listings, xcolor}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\newcommand{\noncopynumber}[1]{% keep line numbers from being copied in code listings
    \BeginAccSupp{method=escape,ActualText={}}
    #1
    \EndAccSupp{}
}
\lstset{frame=tb,
    language=\defaultlanguage,
    aboveskip=3mm,
    belowskip=3mm,
    showstringspaces=false,
    columns=flexible,
    basicstyle={\small\ttfamily},
    numberstyle=\scriptsize\noncopynumber,
    keywordstyle=\color{blue},
    commentstyle=\color{dkgreen},
    stringstyle=\color{mauve},
    breaklines=true,
    breakatwhitespace=true,
    tabsize=3,
    numbers=left,
}

\lstnewenvironment{code}{\lstset{language=\defaultlanguage}}{}
\lstnewenvironment{latexcode}{\lstset{language=Tex}}{}








\RequirePackage{anyfontsize}
\RequirePackage{graphicx}
\definecolor{winered}{rgb}{0.5,0,0}
\definecolor{epubblue}{RGB}{1,126,218}
\RequirePackage{xpatch}
\RequirePackage{hyperref}
\hypersetup{
    pdfborder={0 0 0},
    colorlinks,
    colorlinks=true, %set true if you want colored links
    linktoc=all,     %set to all if you want both sections and subsections linked
    citecolor=ecolor,
    filecolor=ecolor,
    linkcolor=ecolor, %epubblue,
    urlcolor=ecolor
}
% list/itemize/enumerate setting
%%% \RequirePackage[shortlabels,inline]{enumitem}
%%% \setlist{nolistsep}
\RequirePackage[flushmargin,stable]{footmisc}
\setlength{\footnotesep}{12pt}
\RequirePackage{titlesec}
\titleformat*{\section}{\normalfont\Large\bfseries\color{ecolor}}
\titleformat*{\subsection}{\normalfont\large\bfseries\color{ecolor}}
\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries\color{ecolor}}
% Define colors
\ifdefstring{\ALB@color}{green}{
    \definecolor{ecolor}{RGB}{0,120,2}%
    \definecolor{main}{RGB}{0,120,2}%
    \definecolor{second}{RGB}{230,90,7}%
    \definecolor{third}{RGB}{0,160,152}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{cyan}{
    \definecolor{ecolor}{RGB}{31,186,190}%
    \definecolor{main}{RGB}{59,180,5}%
    \definecolor{second}{RGB}{175,153,8}%
    \definecolor{third}{RGB}{244,105,102}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{blue}{
    \definecolor{ecolor}{RGB}{1,126,218}%
    \definecolor{main}{RGB}{0,166,82}%
    \definecolor{second}{RGB}{255,134,24}%
    \definecolor{third}{RGB}{0,174,247}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{sakura}{
    \definecolor{ecolor}{RGB}{255,183,197}%
    \definecolor{main}{RGB}{59,180,5}%
    \definecolor{second}{RGB}{175,153,8}%
    \definecolor{third}{RGB}{244,105,102}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{black}{
    \definecolor{ecolor}{RGB}{0,0,0}%
    \definecolor{main}{RGB}{0,0,0}%
    \definecolor{second}{RGB}{0,0,0}%
    \definecolor{third}{RGB}{0,0,0}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{brown}{
    \definecolor{ecolor}{RGB}{109,62,18}%
    \definecolor{main}{RGB}{0,166,82}%
    \definecolor{second}{RGB}{255,134,24}%
    \definecolor{third}{RGB}{0,174,247}%
    \definecolor{textcol}{RGB}{0,0,0}
}{\relax}
\ifdefstring{\ALB@color}{white}{
    \definecolor{ecolor}{RGB}{255,255,255}%
    \definecolor{main}{RGB}{0,166,82}%
    \definecolor{second}{RGB}{255,134,24}%
    \definecolor{third}{RGB}{0,174,247}%
    \definecolor{textcol}{RGB}{255,255,255}
}{\relax}

\RequirePackage{hologo}
% good for eye color 
\ifdefstring{\ALB@mode}{geye}{
    \definecolor{geyecolor}{RGB}{199,237,204}%
    \pagecolor{geyecolor}
}{\relax}
\ifdefstring{\ALB@mode}{hazy}{
    \definecolor{geyecolor}{RGB}{251,250,248}%
    \pagecolor{geyecolor}
}{\relax}
\ifdefstring{\ALB@mode}{sepia}{
    \definecolor{geyecolor}{RGB}{250,237,225}%
    \pagecolor{geyecolor}
}{\relax}
\ifdefstring{\ALB@mode}{night}{
    \definecolor{textcol}{RGB}{255,255,255}
    \definecolor{nightcolor}{RGB}{64,64,64}%
    %\pagecolor{nightcolor}
    \renewcommand{\thmopacity}{0.1}
    \lstset{
        keywordstyle=\color{second},
        commentstyle=\color{third},
        stringstyle=\color{main},
    }
    
    \RequirePackage{background}
    \backgroundsetup{
        scale=1,
        color=black,
        opacity=1,
        angle=0,
        contents={
            \includegraphics[width=\paperwidth,height=\paperheight]{\nightmodebackground}
        }
    }
}{\relax}
\let\openbox\relax
\newcommand{\globalcolor}[1]{%
    \color{#1}\global\let\default@color\current@color
}
\AtBeginDocument{\globalcolor{textcol}}
\definecolor{egreen}{RGB}{0,120,2}
\definecolor{ecyan}{RGB}{0,175,152}
\definecolor{eblue}{RGB}{20,50,104}
\definecolor{sakura}{RGB}{255,183,197}
\definecolor{brown}{RGB}{109,62,18}
% tikz
\RequirePackage{tikz}
\usetikzlibrary{angles,quotes}
\usetikzlibrary{shadows}
\newcommand*{\eitemi}{
    \tikz\draw[baseline, ball color=ecolor, draw=none] circle (2pt);}
\newcommand*{\eitemii}{
    \tikz\draw[baseline, fill=ecolor,draw=none,circular drop shadow] circle (2pt);}
\newcommand*{\eitemiii}{%
    \tikz\draw[baseline,fill=ecolor,draw=none] circle (2pt);}
%enumerate and itemize settings
\setlist[enumerate,1]{label=\color{ecolor}\arabic*.}
\setlist[enumerate,2]{label=\color{ecolor}(\alph*).}
\setlist[enumerate,3]{label=\color{ecolor}\Roman*.}
\setlist[enumerate,4]{label=\color{ecolor}\Alph*.}
\setlist[itemize,1]{label={\eitemi}}
\setlist[itemize,2]{label={\eitemii}}
\setlist[itemize,3]{label={\eitemiii}}
% source1: https://tex.stackexchange.com/questions/41408/a-five-level-deep-list
% source2: https://tex.stackexchange.com/questions/318199/change-color-of-itemize-bullet 
\RequirePackage{changepage} % for adjustwidth environment
\newcommand{\indenv}[2][1]{
    \begin{adjustwidth}{#1cm}{}
        #2
    \end{adjustwidth}
}
%number line in * environment, add \lebel{} and refer as \eqref{}
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}

















\RequirePackage{clsfiles/shortcuts}
%color boxes
\RequirePackage[breakable, skins, theorems]{tcolorbox}
%use \tcblower for break
%use {Title}{Ref} lemma:Ref for reference, e.g. nameref, pageref, ref
\theoremstyle{\thmstyle}
\RequirePackage{clsfiles/tcbthm}






\pagestyle{style}
\RequirePackage[skip=\skippar, indent=\indentpar]{parskip}
