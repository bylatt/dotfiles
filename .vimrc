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

" Plugins to install
Bundle 'gmarik/vundle'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'troydm/easybuffer.vim'
Bundle 'justinmk/vim-sneak'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'moll/vim-node'
Bundle 'guileen/vim-node-dict'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jelera/vim-javascript-syntax'

" Settings
set nocompatible
set shell=/bin/zsh
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set t_Co=256
set background=dark
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set nowrap
set nospell
set modeline
set backspace=2
set laststatus=2
set showmode
set showcmd
set cmdheight=1
set ttyfast
set confirm
set noruler
set number
set nocursorline
set nocursorcolumn
set visualbell
set noerrorbells
set autoread
set hidden
set binary
set noeol
set clipboard+=unnamed
set scrolloff=4
set gdefault
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch
set infercase
set wrapscan
set magic
set nobackup
set nowritebackup
set noswapfile
set history=100
set nolist 
set listchars=tab:▸\ ,trail:·,eol:¬
set wildmenu
set wildmode=list:longest,full
set wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set statusline=[%n]\ %t\ %y\ %M\ %=\ %l\/\%L\ %v\ [0x%B]
set splitbelow
set splitright
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" Colors and Indent
filetype plugin indent on
syntax on
colorscheme solarized 
if has('gui_running')
	set guifont=Source\ Code\ Pro:h13
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=L
endif

" Keys mapping
let mapleader=","
let g:mapleader=","

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

inoremap <leader><tab> <c-x><c-o>
inoremap <expr> j ((pumvisible())?("\<c-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<c-p>"):("k"))

inoremap <leader>e <esc>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <cr> :nohlsearch<cr>
nnoremap <leader>ea :EasyBuffer<cr>

" Per filetype settings
autocmd FileType markdown setlocal nonumber spell wrap laststatus=0
autocmd FileType php nnoremap <c-r> :!clear && php %<cr>
autocmd FileType javascript nnoremap <c-r> :!clear && node %<cr>