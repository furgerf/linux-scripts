" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.
set relativenumber  " Show relative line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

set textwidth=256   " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.-
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

set mouse=nr        " Enable the use of the mouse. SHOULD BE 'a'

filetype plugin indent on
syntax on

" key mapping: general
map <S-T> :tabe 
map <F8> :tabn<CR>
map <S-F8> :tabp<CR>

" key mapping: c
autocmd FileType c map <F2> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>

" key mapping: scripts
autocmd FileType lua\|sh map <F2> :!"%:p"<CR>

" key mapping: tex
autocmd FileType tex map <F2> :!cd %:p:h && rm -f "%:p:r.pdf" && pdflatex "%:p:r.tex" && okular &> /dev/null "%:p:r.pdf" &<CR>

" key mapping: bib
autocmd FileType bib map <F2> :!cd %:p:h && for i in *.aux; do bibtex $i; done<CR>

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_GotoError=0
map <m-a> ggVG


set clipboard=unnamed
set encoding=utf-8

set t_Co=256
colorscheme fu

" allow saving files as sudo
cmap sudow w !sudo tee > /dev/null %

set pastetoggle=<F4>

" make j/k move down/up one ROW rather than one LINE
nmap j gj
nmap k gk

" unhighlight search results
nmap \q :nohlsearch<CR>

" show some whitespaces
set list
"set listchars=eol:$,tab:->,trail:~
set listchars=trail:~,tab:»·,eol:⏎

" load pathogen
execute pathogen#infect()

" turn off arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" spellcheck
autocmd FileType tex setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
" word complete
set complete+=kspell

" highlight long rows
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" add blinkhighlight when browsing trough matches
function! HLNext (blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
  call matchdelete(ring)
  redraw
endfunction

