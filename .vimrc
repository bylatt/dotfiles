silent! runtime bundle/vim-pathogen/autoload/pathogen.vim
silent! execute pathogen#infect()

set nocompatible
set shell=/bin/zsh
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
set incsearch ignorecase smartcase showmatch hlsearch infercase
set nobackup nowritebackup noswapfile
set history=100
set shortmess=atI
set list listchars=tab:▸\ ,trail:·,eol:¬
set wildmenu wildmode=list:longest,full wildignore=*.png,*.jpg,*gif
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set splitbelow splitright
let g:currentmode={
	\ 'n'  : 'Normal',
	\ 'no' : 'N·Operator Pending',
	\ 'v'  : 'Visual',
	\ 'V'  : 'V·Line',
	\ '' : 'V·Block',
	\ 's'  : 'Select',
	\ 'S'  : 'S·Line',
	\ '' : 'S·Block',
	\ 'i'  : 'Insert',
	\ 'R'  : 'Replace',
	\ 'Rv' : 'V·Replace',
	\ 'c'  : 'Command',
	\ 'cv' : 'Vim Ex',
	\ 'ce' : 'Ex',
	\ 'r'  : 'Prompt',
	\ 'rm' : 'More',
	\ 'r?' : 'Confirm',
	\ '!'  : 'Shell',
	\}
set statusline=[%F]\ %m\ %=\ [%{toupper(g:currentmode[mode()])}]\ [%Y]\ [%l/%L]\ [%p%%]

filetype plugin indent on
syntax on
colorscheme hemisu

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

autocmd FileType markdown setlocal nonumber spell wrap
