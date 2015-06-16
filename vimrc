" NeoBundle Settings            {{{
" ---------------------------------
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundleFetch 'shougo/neobundle.vim'
NeoBundle 'shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'shougo/unite.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'sirver/ultisnips'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'bling/vim-airline'
NeoBundle 'honza/vim-snippets'
NeoBundle 'gabrielelana/vim-markdown'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'justmao945/vim-clang'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'kballard/vim-swift'
NeoBundle 'fatih/vim-go'
call neobundle#end()
" }}}
" Vim Settings                  {{{
" ---------------------------------
set nocompatible
set sh=$SHELL
set term=$TERM
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set t_Co=256
set t_ut=
set t_vb=
set background=light
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set copyindent
set nowrap nospell
set backspace=2
set laststatus=2
set showtabline=0
set showmode showcmd
set noruler number norelativenumber
set cursorline nocursorcolumn
set noerrorbells novisualbell
set hidden
set binary
set endofline
set scrolloff=4
set gdefault
set incsearch
set hlsearch
set smartcase
set ignorecase
set infercase
set showmatch
set matchtime=10
set nobackup
set nowritebackup
set noswapfile
set list
set listchars=tab:\ \ ,trail:\ ,extends:#,eol:\ ,nbsp:.
set fillchars=vert:\|,fold:\
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set wildmenu
set wildmode=list:longest,full
set wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*
set statusline=%{getcwd()}/%f\ %{fugitive#head()}\ %m\ %{SyntasticStatuslineFlag()}\ %=\ [%l,%c]\ [%L,%p%%]
" set statusline=%1*%{getcwd()}/%2*%f\ %1*%{fugitive#head()}\ %m\ %3*%{SyntasticStatuslineFlag()}\ %1*%=\ [%l,%c]\ [%L,%p%%]
set splitbelow
set splitright
set ttyfast
set timeout
set timeoutlen=1000
set ttimeoutlen=200
set nofoldenable
set foldmethod=indent
set foldlevel=1
set conceallevel=0
set concealcursor=i
set history=100
set clipboard+=unnamed
set tags=./tags;
" }}}
" Color and Syntax              {{{
" ---------------------------------
if has('gui_running')
  set guifont=Inconsolata\ LGC\ for\ Powerline:h14
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
endif
filetype plugin indent on
syntax on
colorscheme solarized
" }}}
" Improve color scheme          {{{
" ---------------------------------
highlight Normal ctermbg=none
highlight CursorLine cterm=none ctermbg=none
highlight CursorLineNr cterm=none ctermbg=none
highlight NonText cterm=none ctermbg=none
highlight SpecialKey cterm=none ctermbg=none
" highlight NonText cterm=none ctermbg=none ctermfg=236
" highlight SpecialKey cterm=none ctermbg=none ctermfg=236
" highlight CursorLine cterm=none ctermbg=none
" highlight CursorLineNr cterm=none ctermbg=none ctermfg=220
" highlight LineNr cterm=none ctermbg=none ctermfg=236
" highlight StatusLine cterm=none ctermbg=15 ctermfg=242
" highlight StatusLineNC cterm=none ctermbg=none ctermfg=232
" highlight IncSearch cterm=none ctermbg=220 ctermfg=236
" highlight User1 cterm=none ctermbg=15 ctermfg=242
" highlight User2 cterm=bold ctermbg=15 ctermfg=232
" highlight User3 cterm=none ctermbg=15 ctermfg=1
" }}}
" Keys mapping                  {{{
" ---------------------------------
let g:mapleader=' '
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
vmap <  <gv
vmap > >gv
nmap <cr> :noh<cr>
inoremap jk <esc>
inoremap kj <esc>
nnoremap ; :
nnoremap ! :!
" }}}
" Netrw                         {{{
" ---------------------------------
function! VexToggle(dir)
  if exists('t:vex_buf_nr')
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endfunction

function! VexOpen(dir)
  let g:netrw_browse_split=4
  let vex_width=30
  execute 'Vexplore '.a:dir
  let t:vex_buf_nr=bufnr('%')
  wincmd H
  call VexSize(vex_width)
endfunction

function! VexClose()
  let cur_win_nr=winnr()
  let target_nr=(cur_win_nr==1?winnr('#'):cur_win_nr)
  1wincmd w
  close
  unlet t:vex_buf_nr
  execute (target_nr-1).'wincmd w'
  call NormalizeWidths()
endfunction

function! VexSize(vex_width)
  execute 'vertical resize'.a:vex_width
  set winfixwidth
  call NormalizeWidths()
endfunction

function! NormalizeWidths()
  let eadir_pref=&eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection=eadir_pref
endfunction

augroup NetrwGroup
  autocmd! bufenter * call NormalizeWidths()
augroup END

let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_list_hide=&wildignore

noremap <leader>n :call VexToggle(getcwd())<cr>
" }}}
" UltiSnips                     {{{
" ---------------------------------
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'
" }}}
" Syntastic                     {{{
" ---------------------------------
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=0
let g:syntastic_haml_checkers=['haml']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['node', 'standard']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✠'
let g:syntastic_warning_symbol='∆'
let g:syntastic_style_warning_symbol='≈'
" }}}
" Tagbar                     {{{
" ---------------------------------
nnoremap <leader>t :TagbarToggle<cr>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
" }}}
" Airline                       {{{
" ---------------------------------
let g:airline_powerline_fonts=0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" }}}
" JavaScript syntax             {{{
" ---------------------------------
let g:javascript_enable_domhtmlcss=1
" }}}
" Unite                         {{{
" ---------------------------------
nnoremap <leader>p :Unite -no-split -start-insert file_rec/async:!<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>
let g:unite_source_history_yank_enable=1
let g:unite_prompt='→ '
let g:unite_split_rule='topleft'
let g:unite_data_directory=$HOME.'/.vim/tmp/unite'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec/async,file_rec,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.svn/',
      \ '\.hg/',
      \ '\.cache/',
      \ 'tmp/',
      \ 'node_modules/',
      \ 'vendor/',
      \ 'bower_components/',
      \ '.sass-cache',
      \ ], '\|'))
let s:ag_opts = '-SU --hidden --nocolor --nogroup '.
      \ '--ignore ".git" '.
      \ '--ignore ".svn" '.
      \ '--ignore ".hg" '.
      \ '--ignore ".DS_Store" '.
      \ '--ignore ".cache" '.
      \ '--ignore "bower_components" '.
      \ '--ignore "node_modules" '.
      \ '--ignore "vendor" '.
      \ '--ignore "*.ttf" '.
      \ '--ignore "*.png" '.
      \ '--ignore "*.jpg" '.
      \ '--ignore "*.gif" '.
      \ '--ignore "**/*.pyc"'
if executable('ag')
  let g:unite_source_rec_async_command='ag --follow '.s:ag_opts.' -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-i --line-numbers '.s:ag_opts
  let g:unite_source_grep_recursive_opt = ''
endif

function! s:unite_settings()
  imap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <c-j> <plug>(unite_select_next_line)
  imap <buffer> <c-k> <plug>(unite_select_previous_line)
endfunction

autocmd filetype unite call s:unite_settings()
" }}}
" Note                          {{{
" ---------------------------------
" Default vim key binding for autocomplete
" <c-x><c-f> for path completion
" <c-x><c-l> for whole line completion
" <c-x><c-o> for omnifunc completion
" <c-x><c-u> for completefunc completion
" <c-x><c-]> for tag conpletion
" <c-n> for completion for next match keyword
" <c-p> for completion for previous match keyword
" When stage is on option list
" <c-n> for next option
" <c-p> for previous option
" }}}
" Filetype                      {{{
" ---------------------------------
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype zsh setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype vim setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype php setlocal expandtab smartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
autocmd filetype ruby setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
autocmd filetype python setlocal expandtab nosmartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=indent
autocmd filetype javascript setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
" }}}
