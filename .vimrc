" Setting up Vundle
let has_vundle=1
let VundleReadme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(VundleReadme)
	echo "Installing Vundle..."
	silent !mkdir -p ~/.vim/bundle
	silent !git clone git@github.com:gmarik/Vundle.vim.git ~/.vim/bundle/vundle
	let has_vundle=0
endif
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-vinegar'
Bundle 'pangloss/vim-javascript'
Bundle 'clozed2u/vim-sass'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'noahfrederick/vim-hemisu'

" Settings
set nocompatible
set shell=/usr/local/bin/zsh
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set t_Co=256
set background=dark
set expandtab
set shiftwidth=2 tabstop=2 softtabstop=2
set autoindent smartindent
set nowrap
set nospell
set nomodeline
set backspace=2
set laststatus=2
set showmode
set showcmd
set confirm
set noruler
set number
set cursorline nocursorcolumn
set showtabline=2
set visualbell noerrorbells
set autoread
set hidden
set binary noeol
set clipboard=unnamed
set scrolloff=4
set magic
set gdefault
set incsearch ignorecase smartcase showmatch hlsearch infercase wrapscan
set nobackup nowritebackup noswapfile
set history=100
set shortmess=atI
set list listchars=tab:▸\ ,trail:·,eol:¬
set wildmenu wildmode=list:longest,full wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set splitbelow splitright
set statusline=[%F]\ %m\ %=\ [%Y]\ [%l/%L]\ [%p%%]

" Colors and Indent
filetype plugin indent on
syntax on
colorscheme hemisu

" Keys mapping
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap <expr> j ((pumvisible())?("\<c-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<c-p>"):("k"))

let mapleader=","
let g:mapleader=","

inoremap <leader>e <esc>

inoremap <leader><tab> <C-x><C-o>

noremap <leader>c <c-_><c-_>

noremap <leader>t <esc>:tabnew<cr>

noremap <leader>s <esc>:split<cr>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <cr> :nohlsearch<cr>

" Per filetype settings
autocmd FileType markdown setlocal nonumber spell wrap laststatus=0 showtabline=0
