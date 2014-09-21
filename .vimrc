" Setting up Vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/autoload/vundle.vim'))
  silent !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'gmarik/vundle.vim'
Plugin 'reedes/vim-colors-pencil'
Plugin 'edsono/vim-matchit'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'bling/vim-airline'
Plugin 'kopischke/vim-mklib'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'justinmk/vim-sneak'
Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
call vundle#end()

" Settings
se nocp
se sh=/bin/zsh
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se t_ut=
se bg=dark
se et sta sw=2 ts=2 sts=2 ai si
se nowrap nospell
se bs=2
se ls=2
se smd sc ch=1
se noru nu
se cul nocuc
se novb noeb
se smd
se sc
se ar
se hid
se bin
se noeol
se so=4
se gd
se is scs ic hls inf
se sm mat=10
se ws
se magic
se nobk nowb noswf
se list lcs=tab:▸·,trail:·,eol:¬
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se stl=[%n]\ %t\ %y\ %M\ %=\ [%l\/\%L\ %v]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata\ XL:h14
	se go-=mTrL
endif
filetype plugin indent on
syntax on
colo pencil

" Keys mapping
let mapleader=','
let g:mapleader=','

ino <expr> j ((pumvisible())?("\<c-n>"):("j"))
ino <expr> k ((pumvisible())?("\<c-p>"):("k"))
ino <leader>e <esc>

nno <c-j> <c-w>j
nno <c-k> <c-w>k
nno <c-h> <c-w>h
nno <c-l> <c-w>l
nno <cr> :nohls<cr>

" Per filetype settings
au filetype markdown setl nonu spell wrap

" Plugin settings
let g:airline_theme = 'pencil'
let g:airline_powerline_fonts = 1
