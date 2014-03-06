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
Bundle 'noahfrederick/vim-hemisu'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-markdown'
Bundle 'justinmk/vim-sneak'
Bundle 'mattn/emmet-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'troydm/easybuffer.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'othree/javascript-libraries-syntax.vim'

" Settings
set nocompatible
set shell=/bin/zsh
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set t_Co=256
set background=dark
set expandtab shiftwidth=2 tabstop=2 softtabstop=2
set autoindent smartindent
set nowrap
set nospell
set modeline
set backspace=2
set laststatus=2
set showmode
set showcmd
set confirm
set noruler
set number
set nocursorline nocursorcolumn
"set showtabline=0
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
set nolist listchars=tab:▸\ ,trail:·,eol:¬
set wildmenu wildmode=list:longest,full wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set splitbelow splitright
set statusline=%F\ %m\ %=\ %Y\ [LN\ %l/%L:%p%%]
set timeout timeoutlen=1000 ttimeoutlen=100

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

let mapleader=","
let g:mapleader=","

inoremap <leader><tab> <C-x><C-o>
inoremap <expr> j ((pumvisible())?("\<c-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<c-p>"):("k"))

inoremap <leader>e <esc>

noremap <leader>t <esc>:tabnew<cr>

noremap <leader>s <esc>:split<cr>
noremap <leader>vs <esc>:vsplit<cr>

nnoremap + <c-w>+
nnoremap - <c-w>-
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <cr> :nohlsearch<cr>

nnoremap <leader>ea :EasyBuffer<cr>
" Per filetype settings
autocmd FileType markdown setlocal nonumber spell wrap laststatus=0 showtabline=0

augroup HTMLCmds
	autocmd Filetype html nnoremap <leader>c I<!--<esc>A--><esc>
augroup END

augroup JavaScriptCmds
	autocmd!
	autocmd Filetype javascript nnoremap <leader>r :!node %<cr>
	autocmd Filetype javascript nnoremap <leader>c I//<esc>
augroup END

