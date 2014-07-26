" Setting up Vundle
if !filereadable(expand('~/.vim/bundle/vundle/README.md'))
	silent !git clone git@github.com:gmarik/Vundle.vim.git ~/.vim/bundle/vundle
endif
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'cocopon/iceberg.vim'
Plugin 'troydm/easybuffer.vim'
Plugin 'troydm/easytree.vim'
Plugin 'edsono/vim-matchit'
Plugin 'thinca/vim-quickrun'
Plugin 'rainux/vim-desert-warm-256'
Plugin 'junegunn/vim-easy-align'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-abolish'
Plugin 'justinmk/vim-sneak'
Plugin 'pangloss/vim-javascript'
Plugin 'moll/vim-node'
Plugin 'ahayman/vim-nodejs-complete'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'

call vundle#end()

" Settings
se nocp
se sh=/bin/zsh
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se bg=dark
se et sta sw=4 ts=4 sts=4 ai si
se nowrap nospell
se bs=2
se ls=2
se smd sc ch=1
se noru nu
se nocul nocuc
se novb noeb
se ar
se hid
se bin
se noeol
se so=4
se gd
se is scs ic sm hls inf
se ws
se magic
se nobk nowb noswf
se list lcs=tab:▸\ ,trail:·,eol:¬
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se stl=[%n]\ %t\ %y\ %M\ %=\ %l\/\%L\ %v\ [0x%B]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=indent
se clipboard=unnamedplus
se history=100

" Colors and Indent
filetype plugin indent on
syntax on
colo desert

" Keys mapping
let mapleader=","
let g:mapleader=","

nn ; :
nn : ;
vn ; :
vn : ;

ino <expr> j ((pumvisible())?("\<c-n>"):("j"))
ino <expr> k ((pumvisible())?("\<c-p>"):("k"))

ino <leader>e <esc>

nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-h> <c-w>h
nn <c-l> <c-w>l

nn <cr> :nohls<cr>
nn <leader>eb :EasyBuffer<cr>
nn <leader>et :EasyTree<cr>

" Per filetype settings
au filetype markdown setl nonu spell wrap