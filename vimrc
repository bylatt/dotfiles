" NeoBundle Settings {{{
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundle 'shougo/neobundle.vim'
NeoBundle 'shougo/vimproc.vim', {'build':{'unix': 'make'}}
NeoBundle 'shougo/unite.vim', {'depends': 'shougo/vimproc.vim'}
" NeoBundle 'shougo/vimfiler.vim', {'depends': 'shougo/unite.vim'}
NeoBundle 'wellle/targets.vim'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ervandew/supertab'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'gabrielelana/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'wakatime/vim-wakatime'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'kana/vim-arpeggio', {'build': {'unix': 'make'}}
NeoBundle 'sickill/vim-pasta'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rails'
NeoBundle 'mtscout6/vim-cjsx', {'depends': 'kchmck/vim-coffee-script'}
NeoBundle 'mxw/vim-jsx', {'depends': 'pangloss/vim-javascript'}
NeoBundle 'fatih/vim-go'
call neobundle#end()
" }}}
" Vim Settings {{{
set nocompatible
set sh=$SHELL
set term=$TERM
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb
set t_Co=256
set t_ut=
set t_vb=
set background=dark
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set copyindent
set cindent
set autowrite
set autoread
set nowrap
set backspace=2
set laststatus=0
set showtabline=0
set showcmd
set number
set cursorline
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
set endofline
set listchars=tab:\ \ ,trail:\ ,extends:#,eol:\ ,nbsp:.
set fillchars=vert:\|,fold:\
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set wildmenu
set wildmode=list:longest,full
set wildignore=*.png,*.jpg,*gif,*.gem,*.so,*.swp,*.zip,*.gz,*DS_Store*,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*,.composer/*,.gem/*
set statusline=%{getcwd()}/%f\ %{fugitive#head()}\ %m\ %{SyntasticStatuslineFlag()}\ %=\ [%l,%c]\ [%L,%p%%]
set splitbelow
set splitright
set timeoutlen=2000
set ttimeoutlen=200
set nofoldenable
set foldmethod=indent
set foldlevel=1
set concealcursor=i
set clipboard+=unnamed,unnamedplus
" }}}
" Color and Syntax {{{
if has('gui_running')
  set guifont=Inconsolata\ LGC:h14
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
endif
filetype plugin indent on
syntax on
colorscheme xoria256
" }}}
" Improve color scheme {{{
highlight Normal                   ctermbg=none
highlight NonText      cterm=none  ctermbg=none
highlight SpecialKey   cterm=none  ctermbg=none
highlight CursorLine   cterm=none  ctermbg=none
highlight CursorLineNr cterm=none  ctermbg=none
highlight LineNr       cterm=none  ctermbg=none
" }}}
" Keys mapping {{{
let g:mapleader=' '
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
vmap <  <gv
vmap > >gv
nmap <cr> :noh<cr>
nnoremap ; :
nnoremap ! :!
" }}}
" Unite {{{
nnoremap <leader>p :Unite -no-split -start-insert file_rec/async:!<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>
let g:unite_winheight=15
let g:unite_prompt='>> '
let g:unite_split_rule='topleft'
let g:unite_data_directory=$HOME.'/.vim/tmp/unite'
let g:unite_source_rec_max_cache_files=0
let g:unite_source_history_yank_enable=1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec/async',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.svn/',
      \ '\.hg/',
      \ '\.cache/',
      \ '\.composer/',
      \ '\.gem/',
      \ '\.sass-cache',
      \ '\.config/',
      \ 'tmp/',
      \ 'node_modules/',
      \ 'vendor/',
      \ 'bower_components/',
      \ ], '\|'))
call unite#custom#source('file_rec/async', 'converters', [])
call unite#custom#source('file_rec/async', 'sorters', [])
call unite#custom#source('file_rec/async', 'max_candidates', 15)
if executable('ag')
  let s:ag_opts = '-SU --hidden --nocolor --nogroup'
  let g:unite_source_rec_async_command='ag --follow '.s:ag_opts.' -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-i --line-numbers '.s:ag_opts
  let g:unite_source_grep_recursive_opt = ''
endif

function! s:unite_settings()
  Arpeggio inoremap jk <esc>
  imap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <c-j> <plug>(unite_select_next_line)
  imap <buffer> <c-k> <plug>(unite_select_previous_line)
endfunction

autocmd filetype unite call s:unite_settings()
" }}}
" Vimfiler {{{
" let g:vimfiler_data_directory=$HOME.'/.vim/tmp/vimfiler'
" let g:vimfiler_as_default_explorer=1
" let g:vimfiler_safe_mode_by_default=0
" let g:vimfiler_tree_leaf_icon=" "
" let g:vimfiler_tree_opened_icon='▾'
" let g:vimfiler_tree_closed_icon='▸'
" let g:vimfiler_file_icon='-'
" let g:vimfiler_marked_file_icon='✓'
" let g:vimfiler_readonly_file_icon='✗'
" let g:vimfiler_time_format='%m-%d-%y %H:%M:%S'
" let g:vimfiler_expand_jump_to_first_child=0
" let g:vimfiler_ignore_pattern='\.git\|\.DS_Store\|\.pyc'

" nnoremap <leader>n :<c-u>VimFilerExplorer -split -simple -parent -winwidth=35 -toggle -no-quit<cr>
" nnoremap <leader>jf :<c-u>VimFilerExplorer -split -simple -parent -winwidth=35 -no-quit -find<cr>
" autocmd FileType vimfiler nunmap <buffer> x
" autocmd FileType vimfiler nmap <buffer> x <plug>(vimfiler_toggle_mark_current_line)
" autocmd FileType vimfiler vmap <buffer> x <plug>(vimfiler_toggle_mark_selected_lines)
" autocmd FileType vimfiler nunmap <buffer> l
" autocmd FileType vimfiler nmap <buffer> l <plug>(vimfiler_cd_or_edit)
" autocmd FileType vimfiler nmap <buffer> h <plug>(vimfiler_switch_to_parent_directory)
" autocmd FileType vimfiler nunmap <buffer> <c-l>
" autocmd FileType vimfiler nmap <buffer> <c-r> <plug>(vimfiler_redraw_screen)
" autocmd FileType vimfiler nmap <silent><buffer><expr> <cr> vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", "\<plug>(vimfiler_edit_file)")
" }}}
" Syntastic {{{
let g:syntastic_check_on_open=0
let g:syntastic_aggregate_errors=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_haml_checkers=['haml']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_disabled_filetypes=['go']
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✠'
let g:syntastic_warning_symbol='∆'
let g:syntastic_style_warning_symbol='≈'
autocmd bufwritepost *.js silent !standard % --forMath
" }}}
" Arpeggio {{{
function! s:javascript()
  Arpeggio inoremap fin function<space>
  Arpeggio inoremap con console.log
  Arpeggio inoremap thi this
  Arpeggio inoremap ten .then
  Arpeggio inoremap req require('')<left><left>
  Arpeggio inoremap var var<space>
  Arpeggio inoremap doc document.
  Arpeggio inoremap win window.
  Arpeggio inoremap pro .prototype.
  Arpeggio inoremap ary Array
  Arpeggio inoremap obj Object
  Arpeggio inoremap len .length
  Arpeggio inoremap aug arguments
  Arpeggio inoremap rea fs.readFile
  Arpeggio inoremap jsp JSON.parse
  Arpeggio inoremap jst JSON.stringify
  Arpeggio inoremap bin .bind
  Arpeggio inoremap mep module.exports
  Arpeggio inoremap new new<space>
  Arpeggio inoremap ife if<space>()<space>{<cr>}<esc>kf(a
endfunction

function! s:ruby()
  Arpeggio inoremap put puts<space>
  Arpeggio inoremap xv, cases do<cr>end<esc>O<tab>
  Arpeggio inoremap xv. loop do<cr>end<esc>O<tab>
  Arpeggio inoremap req require ''<left>
  Arpeggio inoremap whi while<cr>end<esc>kA<space>
  Arpeggio inoremap fin def<cr>end<esc>kA<space>
  Arpeggio inoremap cla class
  Arpeggio inoremap ges gets
  Arpeggio inoremap ife if<cr>end<esc>kA<space>
  Arpeggio inoremap els else
  Arpeggio inoremap new .new
endfunction

function! s:php()
  Arpeggio inoremap put echo<space>
  Arpeggio inoremap pub public<space>
  Arpeggio inoremap pri private<space>
  Arpeggio inoremap fin function<space>()<cr>{<cr>}<esc>2kf(i
  Arpeggio inoremap ife if<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap foe foreach<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap els else
  Arpeggio inoremap whi while<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap doc /**<cr>*<cr>*/<esc>ka<space>
  Arpeggio inoremap cla class<space><cr>{<cr>}<esc>2k$a
endfunction

function! s:common()
  Arpeggio inoremap tui true
  Arpeggio inoremap fal false
  Arpeggio inoremap mat Math
  Arpeggio inoremap ret return<space>
  Arpeggio inoremap jk <esc>
endfunction

autocmd vimenter * call s:common()
autocmd filetype php call s:php()
autocmd filetype ruby call s:ruby()
autocmd filetype javascript call s:javascript()
let g:arpeggio_timeoutlen=30
" }}}
" NERDTree {{{
let g:NERDTreeHijackNreturn=1
let g:NERDTreeWinPos=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
nnoremap <leader>n :NERDTreeToggle<cr>
" }}}
" Tabular {{{
vmap <cr> :Tabularize /
" }}}
" Tagbar {{{
nnoremap <leader>t :TagbarToggle<cr>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }
" }}}
" JavaScript syntax {{{
let g:javascript_enable_domhtmlcss=1
" }}}
" Note {{{
" Default vim key binding for autocomplete
" <c-x><c-f> for path completion
" <c-x><c-l> for whole line completion
" <c-x><c-o> for omnifunc completion
" <c-x><c-u> for completefunc completion
" <c-x><c-]> for tag conpletion
" <c-x><c-k> for dictionary conpletion
" <c-n> for completion for next match keyword
" <c-p> for completion for previous match keyword
" When stage is on option list
" <c-n> for next option
" <c-p> for previous option
" }}}
" Filetype {{{
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype zsh setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype vim setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype php setlocal expandtab smartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
autocmd filetype ruby setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
autocmd filetype python setlocal expandtab nosmartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=indent
autocmd filetype javascript setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
" }}}
