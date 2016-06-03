" github.com/clozed2u :: @clozed2u
" http://clozed2u.com

" Initializations: {{{

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb

" }}}

" Plugin: {{{

if !isdirectory($HOME.'/.vim/bundle/repos/github.com/shougo/dein.vim')
  silent !git clone https://github.com/shougo/dein.vim.git $HOME/.vim/bundle/repos/github.com/shougo/dein.vim
endif

set runtimepath+=$HOME/.vim/bundle/repos/github.com/shougo/dein.vim
call dein#begin(expand($HOME.'/.vim/bundle'))
call dein#add('shougo/dein.vim')
call dein#add('junegunn/fzf.vim')
call dein#add('wellle/targets.vim')
call dein#add('k-takata/matchit.vim')
call dein#add('justinmk/vim-dirvish')
call dein#add('janko-m/vim-test')
call dein#add('sickill/vim-pasta')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('fatih/vim-go')
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('strogonoff/vim-coffee-script')
call dein#add('vim-ruby/vim-ruby')
call dein#add('ecomba/vim-ruby-refactoring')
call dein#add('tpope/vim-rsi')
call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-eunuch')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-commentary')

if dein#check_install()
  call dein#install()
endif

call dein#end()

filetype plugin indent on

" }}}

" Colors: {{{

set t_Co=256
" set termguicolors
if &term=~'256color'
  set t_ut=
endif
syntax on

try
  colorscheme noctu
catch /:E185:/
  colorscheme default
  highlight LineNr cterm=bold ctermfg=white
endtry

" }}}

" Settings: {{{

set shell=$SHELL

" don't allow files with the same name to overwrite each other
set noswapfile
set writebackup
set backupdir=~/.vim/backup
set undofile
set undodir=~/.vim/undo
set directory=~/.vim/tmp
set tags=./tags;

set backspace=2
set laststatus=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
" set shiftround
set expandtab
set smarttab
set autoindent
set smartindent
set cinoptions=>4,l1,p0,)50,*50,t0
set autoread
set autowrite
set autowriteall
set linespace=0

set shortmess=atToOI
set viewoptions+=unix,slash

set wildmenu
set wildmode=list:longest
set wildignore=*.png,*.jpg,*gif,*.gem,*.so,*.swp,*.zip,*.gz,*DS_Store*,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*,.composer/*,.gem/*,.git/*

set showmode
set showcmd
set showtabline=2
set hidden
set number
set ttyfast

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set noshowmatch
set matchtime=0

set splitbelow
set splitright
set nowrap
" set listchars=tab:▸\ ,eol:¬,trail:•,nbsp:.
set listchars=tab:\ \ ,eol:\ ,trail:•,nbsp:.
set list

set timeout
set timeoutlen=200
set ttimeout
set ttimeoutlen=0

set foldenable
" set foldmethod=indent
set foldmethod=manual
set foldlevel=9999

set nocursorline
set nocursorcolumn

set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
" defualt complete=.,w,b,u,t,i
set complete-=i

set scrolloff=0
set synmaxcol=0
set fillchars+=vert:\!

" disable matchparen
" let g:loaded_matchparen=1

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

" OSSpecific: {{{

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

  nnoremap j gj
  nnoremap k gk
  nnoremap qq :q!<cr>

  nnoremap ; :
  nnoremap ! :!
  nnoremap <cr> :nohlsearch<cr>

  vmap <  <gv
  vmap > >gv

  " }}}

  " Navigation: {{{2

  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-h> <c-w>h
  nnoremap <c-l> <c-w>l

  " }}}

" }}}

" File: {{{

augroup filetypespecific
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd filetype vim setlocal foldmethod=marker foldlevel=0
  autocmd filetype zsh setlocal foldmethod=marker foldlevel=0
  autocmd filetype php setlocal shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
  autocmd filetype ruby setlocal foldmethod=syntax
  autocmd filetype make setlocal noexpandtab tabstop=4 softtabstop=4
  autocmd filetype python setlocal nosmartindent tabstop=4 softtabstop=4 shiftwidth=4
  autocmd filetype javascript setlocal foldmethod=syntax
augroup END

" }}}

" PluginSettings: {{{

  " JSX: {{{2

  let g:jsx_ext_required=0

  " }}}

  " Test: {{{2

  let g:test#strategy='basic'
  let g:test#preserve_screen=0
  let test#ruby#rspec#options='--color'

  nmap <silent> <leader>t :TestNearest<cr>
  nmap <silent> <leader>f :TestFile<cr>
  nmap <silent> <leader>a :TestSuite<cr>
  nmap <silent> <leader>l :TestLast<cr>
  nmap <silent> <leader>g :TestVisit<cr>

  " }}}

  " FZF: {{{
  if isdirectory('/usr/local/opt/fzf')
    set runtimepath+=/usr/local/opt/fzf

    let g:fzf_action={'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit'}

    let g:fzf_colors={
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']}
    nnoremap <leader>p :Files<cr>
  endif
  " }}}

" }}}

" Rename: {{{

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    execute ':saveas ' . new_name
    execute ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <leader>n :call RenameFile()<cr>

" }}}

" TrimTrailingWhitespace: {{{

if !&binary && &filetype != 'diff'
  autocmd bufwritepre * :%s/\s\+$//e
endif

" }}}

" Macvim: {{{

if has('gui_running')
  set macligatures
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guifont=Inconsolata\ LGC:h14
endif

" }}}

" Note: {{{

" " Default vim key binding for autocomplete
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
" " When stage is on option list
" <c-n> for next option
" <c-p> for previous option

" }}}
