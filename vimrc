" ------------------------
" Lattapon Yodsuwan's vim
" ------------------------
" Vundle {{{
set rtp+=$HOME/.vim/bundle/vundle.vim
call vundle#begin()
Plugin 'vundlevim/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kchmck/vim-coffee-script'
Plugin 'sickill/vim-pasta'
Plugin 'vim-ruby/vim-ruby'
Plugin 'janko-m/vim-test'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
call vundle#end()
" }}}
" Settings {{{
set nocompatible
set sh=$SHELL
set term=$TERM
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set autowrite
set autoread
set nowrap
set hidden
set history=1024
set backspace=2
set laststatus=2
set showtabline=0
set showcmd
set number
set cursorline
set cursorcolumn
set scrolloff=2
set gdefault
set incsearch
set hlsearch
set smartcase
set ignorecase
set infercase
set showmatch
set matchtime=0
set nobackup
set nowritebackup
set noswapfile
set listchars=tab:›\ ,trail:•,extends:>,eol:\ ,nbsp:.
set list
set fillchars=vert:\|,fold:\
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set wildmenu
set wildmode=list:longest,full
set wildignore=*.png,*.jpg,*gif,*.gem,*.so,*.swp,*.zip,*.gz,*DS_Store*,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*,.composer/*,.gem/*,.git/*
set statusline=%{getcwd()}/%f\ %{fugitive#head()}\ %m\ %{SyntasticStatuslineFlag()}\ %=\ [%l,%c]\ [%L,%p%%]
set splitbelow
set splitright
set ttyfast
set timeout
set timeoutlen=200
set ttimeout
set ttimeoutlen=0
set nofoldenable
set foldmethod=indent
set foldlevel=1
set concealcursor=i
set clipboard+=unnamed,unnamedplus
" }}}
" Color and Syntax {{{
filetype plugin on
filetype indent on
syntax on
colorscheme latt
" }}}
" Keys mapping {{{
let g:mapleader="\<space>"
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
vmap <  <gv
vmap > >gv
nmap <cr> :nohlsearch<cr>
nnoremap ; :
nnoremap ! :!
inoremap jk <esc>
inoremap kj <esc>
" }}}
" Syntastic {{{
let g:syntastic_auto_jump=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=0
let g:syntastic_auto_loc_list=0
let g:syntastic_aggregate_errors=1
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✠'
let g:syntastic_warning_symbol='∆'
let g:syntastic_style_warning_symbol='≈'
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
nnoremap <c-c> :SyntasticCheck<cr>
" }}}
" CtrlP {{{
let g:ctrlp_use_caching=0
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp'
let g:ctrlp_regexp=1
let g:ctrlp_max_files=0
" }}}
" Filetype {{{
if has('autocmd')
  autocmd bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd filetype zsh setlocal foldmethod=marker foldlevel=0
  autocmd filetype vim setlocal foldmethod=marker foldlevel=0
  autocmd filetype php setlocal shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
  autocmd filetype ruby setlocal foldmethod=syntax
  autocmd filetype make setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
  autocmd filetype python setlocal nosmartindent shiftwidth=4 tabstop=4 softtabstop=4
  autocmd filetype javascript setlocal foldmethod=syntax
endif
" }}}
" Test {{{
nmap <silent> <leader>t :TestNearest<cr>
nmap <silent> <leader>f :TestFile<cr>
nmap <silent> <leader>a :TestSuite<cr>
nmap <silent> <leader>l :TestLast<cr>
nmap <silent> <leader>g :TestVisit<cr>
"}}}
" Ag {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command='ag %s --ignore-case --smart-case --skip-vcs-ignores --hidden --nocolor --nogroup -g ""'
  let g:ctrlp_use_caching=0
endif
" }}}
" Note {{{
" Default vim key binding for autocomplete
" <c-x><c-f> for path completion
" <c-x><c-k> for dictionary conpletion
" <c-x><c-l> for whole line completion
" <c-x><c-o> for omnifunc completion
" <c-x><c-u> for completefunc completion
" <c-x><c-]> for tag conpletion
" <c-x><c-n> for keyword in current file
" <c-x><c-v> for vim command line
" <c-n> for completion for next match keyword
" <c-p> for completion for previous match keyword
" When stage is on option list
" <c-n> for next option
" <c-p> for previous option
" }}}
