" NeoBundle Settings            {{{
" ---------------------------------
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundleFetch 'shougo/neobundle.vim'
NeoBundle 'shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'shougo/unite.vim'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'sirver/ultisnips'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'bling/vim-airline'
NeoBundle 'honza/vim-snippets'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'crusoexia/vim-javascript-lib'
NeoBundle 'chriskempson/base16-vim'
call neobundle#end()
" }}}
" Vim Settings                  {{{
" ---------------------------------
set nocompatible
set sh=$SHELL
set term=$TERM
set encoding=utf-8 termencoding=utf-8 fileencoding=utf-8
set t_Co=256
set t_ut=
set t_vb=
set background=dark
set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 autoindent smartindent
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
set incsearch smartcase ignorecase hlsearch infercase
set showmatch matchtime=10
set nobackup nowritebackup noswapfile
set list listchars=tab:\ \ ,trail:\ ,extends:#,eol:\ ,nbsp:.
set fillchars=vert:\|,fold:\
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set wildmenu wildmode=list:longest,full wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*
set statusline=%F%r%h%w\ %{fugitive#head()}\ %m\ %{SyntasticStatuslineFlag()}\ [%l,%c]\ [%L,%p%%]
set splitbelow splitright
set ttyfast timeout timeoutlen=1000 ttimeoutlen=200
set foldenable foldmethod=syntax foldlevel=10
set conceallevel=0 concealcursor=i
set history=100
set clipboard+=unnamed
set tags=./tags;
set copyindent
set path=**
"" }}}
" Color and Syntax              {{{
" ---------------------------------
if has('gui_running')
  set guifont=Inconsolata\ LGC:h14
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set background=light
endif
filetype plugin indent on
syntax on
colorscheme base16-railscasts
" }}}
" Improve color scheme          {{{
" ---------------------------------
" highlight Normal ctermbg=none
" highlight MatchParen cterm=bold
" highlight TabLineSel cterm=bold
" highlight Title cterm=bold
" highlight DiffText cterm=bold
" highlight DiffDelete cterm=bold
" highlight Keyword cterm=bold
" highlight Todo cterm=bold
" highlight Function cterm=bold
" highlight Statement cterm=bold
" highlight Type cterm=bold
" highlight ErrorMsg cterm=bold
" highlight VisualNOS cterm=bold,underline
" highlight NonText cterm=bold
highlight clear SignColumn
highlight VertSplit ctermbg=236
highlight ColorColumn ctermbg=237
highlight LineNr ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine ctermbg=240 ctermfg=12
highlight IncSearch cterm=bold ctermbg=3 ctermfg=1
highlight Search ctermbg=1 ctermfg=3
highlight Visual ctermbg=3 ctermfg=0
highlight Pmenu ctermbg=240 ctermfg=12
highlight PmenuSel ctermbg=3 ctermfg=1
highlight SpellBad ctermbg=0 ctermfg=1

if version >= 700
  autocmd InsertEnter * highlight StatusLine ctermfg=235 ctermbg=2
  autocmd InsertLeave * highlight StatusLine ctermbg=240 ctermfg=12
endif
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
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=0
let g:syntastic_haml_checkers=['haml']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['standard']
" }}}
" Airline                       {{{
" ---------------------------------
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
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
" <c-x><c-f> for pathcompletion
" <c-x><c-l> for whole line completion
" <c-x><c-o> for omnifunc
" <c-x><c-u> for completefunc
" <c-n> for next match keyword
" <c-p> for previous match keyword
" When stage is on option list
" <c-n> for next option
" <c-p> for previous option
" }}}
" Filetype                      {{{
" ---------------------------------
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype zsh setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype vim setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype php setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
autocmd filetype ruby setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
autocmd filetype python setlocal expandtab nosmartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
autocmd filetype javascript setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
" }}}
