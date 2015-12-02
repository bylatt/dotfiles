" github.com/clozed2u :: @clozed2u
" http://clozed2u.com

" Initialization: {{{

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb

" }}}

" Colors: {{{

set t_Co=256
syntax enable
colorscheme xoria256

highlight Normal                   ctermbg=none
highlight NonText      cterm=none  ctermbg=none
highlight SpecialKey   cterm=none  ctermbg=none
highlight CursorLine   cterm=none  ctermbg=none
highlight CursorLineNr cterm=none  ctermbg=none
highlight LineNr       cterm=none  ctermbg=none

" }}}

" Vundle: {{{

let install_vundle = 0

if !isdirectory($HOME.'/.vim/bundle/vundle.vim')
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/vundlevim/vundle.vim ~/.vim/bundle/vundle.vim
  let install_vundle = 1
endif

filetype off

set runtimepath+=~/.vim/bundle/vundle.vim

call vundle#begin()

Plugin 'vundlevim/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'sickill/vim-pasta'
Plugin 'janko-m/vim-test'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'

call vundle#end()

filetype plugin indent on

" }}}

" Settings: {{{

" don't allow files with the same name to overwrite each other
set noswapfile
set writebackup
set backupdir=~/.vim/backups
set undofile
set undodir=~/.vim/undo
set directory=~/.vim/tmp
set tags=./tags;

set backspace=2
set laststatus=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set autowrite
set autoread

set shortmess=atToOI
set viewoptions+=unix,slash

set wildmenu
set wildmode=list:longest
set wildignore=*.png,*.jpg,*gif,*.gem,*.so,*.swp,*.zip,*.gz,*DS_Store*,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*,.composer/*,.gem/*,.git/*

set showmode
set showcmd
set hidden
set number
set ttyfast

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set showmatch
set matchtime=0

set splitbelow
set splitright
set nowrap
" set listchars=tab:▸\ ,eol:¬,trail:•,nbsp:.
set listchars=tab:▸\ ,eol:\ ,trail:•,nbsp:.
set list

set timeout
set timeoutlen=200
set ttimeout
set ttimeoutlen=0

set nofoldenable
set foldmethod=indent
set foldlevel=1

set nocursorline
set nocursorcolumn

set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" }}}

" Tab: {{{

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <expr> <silent> <tab> InsertTabWrapper()

" }}}

" Explorer: {{{

let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_browse_split=0
let g:netrw_list_hide=&wildignore

" }}}

" OS Specific: {{{

let s:kernel = system('echo -n "$(uname -s)"')

" Mac: {{{2

  if s:kernel == 'Darwin'
    set clipboard=unnamed

" }}}

" Linux: {{{2

  elseif s:kernel == 'Linux'
    set clipboard=unnamedplus
  endif

" }}}

" }}}

" Mappings: {{{

let mapleader = "\<space>"

" Modes: {{{2

nnoremap ; :
nnoremap ! :!

vmap <  <gv
vmap > >gv
nmap <cr> :nohlsearch<cr>

" }}}

" Navigation: {{{2

noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" }}}

" }}}

" File: {{{

augroup filetypespecific
  autocmd!
  autocmd bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd filetype zsh setlocal foldmethod=marker foldlevel=0
  autocmd filetype vim setlocal foldmethod=marker foldlevel=0
  autocmd filetype php setlocal tabstop=4 softtabstop=4 foldmethod=syntax
  autocmd filetype ruby setlocal foldmethod=syntax
  autocmd filetype make setlocal noexpandtab tabstop=4 softtabstop=4
  autocmd filetype python setlocal nosmartindent tabstop=4 softtabstop=4
  autocmd filetype javascript setlocal foldmethod=syntax
augroup END

" }}}

" Plugin: {{{

" CtrlP: {{{2

let g:ctrlp_by_filename=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_files=0

if executable('ag')
  let g:ctrlp_user_command='ag %s --ignore-case --smart-case --skip-vcs-ignores --hidden --nocolor --nogroup -g ""'
  let g:ctrlp_use_caching=0
endif

" }}}

" Syntastic: {{{2

let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list=0
let g:syntastic_aggregate_errors=1
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
nnoremap <c-c> :SyntasticCheck<cr>

" }}}

" Test: {{{2

let test#strategy='basic'
nmap <silent> <leader>t :TestNearest<cr>
nmap <silent> <leader>f :TestFile<cr>
nmap <silent> <leader>a :TestSuite<cr>
nmap <silent> <leader>l :TestLast<cr>
nmap <silent> <leader>g :TestVisit<cr>

" }}}

" }}}

" Note: {{{

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
