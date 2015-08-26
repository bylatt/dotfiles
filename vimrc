" NeoBundle Settings {{{
call plug#begin($HOME.'/.vim/bundle')
Plug 'shougo/vimproc.vim', {'do': 'yes \| make'}
Plug 'shougo/unite.vim'
" Plug 'shougo/vimfiler.vim'
Plug 'raimondi/delimitmate'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'ervandew/supertab'
Plug 'tmhedberg/matchit'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'wincent/terminus'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gabrielelana/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'wakatime/vim-wakatime'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'kana/vim-arpeggio'
Plug 'sickill/vim-pasta'
Plug 'vim-ruby/vim-ruby'
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go'
call plug#end()
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
set laststatus=2
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
set statusline=%{getcwd()}/%f\ %m\ %=\ [%l,%c]\ [%L,%p%%]
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
filetype plugin indent on
syntax on
colorscheme c256
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
" autocmd FileType vimfiler nmap <silent><buffer><expr> <cr> vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", '"\<plug>(vimfiler_edit_file)")
" }}}
" Neomake {{{
let g:neomake_open_list=0
let g:neomake_echo_current_error=1
let g:neomake_php_enabled_makers=['phpcs']
let g:neomake_ruby_enabled_makers=['rubocop']
let g:neomake_python_enabled_makers=['flake8']
let g:neomake_javascript_enabled_makers=['jscs']
let g:neomake_error_sign={'text': '>>','texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '>>','texthl': 'WarningMsg'}
noremap <c-c> :Neomake<cr>
" autocmd! BufWritePost * Neomake
" }}}
" Arpeggio {{{
function! s:javascript()
  Arpeggio inoremap fin function()<space>{<cr>}<esc>k$F(a
  Arpeggio inoremap foe .forEach(function() {<cr>})<esc>k$F(a
  Arpeggio inoremap con console.log()<left>
  Arpeggio inoremap thi this.
  Arpeggio inoremap ten .then()<left>
  Arpeggio inoremap req require('')<esc>F'i
  Arpeggio inoremap vai var<space>
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
  Arpeggio inoremap ife if<space>()<space>{<cr>}<esc>k$<left><left>i
endfunction

function! s:ruby()
  Arpeggio inoremap put puts<space>
  Arpeggio inoremap xv, cases<space>do<cr>end<esc>O
  Arpeggio inoremap xv. loop<space>do<cr>end<esc>O
  Arpeggio inoremap req require ''<left>
  Arpeggio inoremap whi while<cr>end<esc>kA<space>
  Arpeggio inoremap fin def<cr>end<esc>kA<space>
  Arpeggio inoremap cla class<cr>end<esc>kA<space>
  Arpeggio inoremap ges gets
  Arpeggio inoremap ife if<cr>end<esc>kA<space>
  Arpeggio inoremap els else
  Arpeggio inoremap new .new
endfunction

function! s:php()
  Arpeggio inoremap put print<space>
  Arpeggio inoremap pub public<space>
  Arpeggio inoremap pri private<space>
  Arpeggio inoremap pam param<space>
  Arpeggio inoremap fin function<space>()<cr>{<cr>}<esc>2kf(i
  Arpeggio inoremap ife if<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap foe foreach<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap els else<space>
  Arpeggio inoremap whi while<space>()<space>{<cr>}<esc>kf(a
  Arpeggio inoremap doc /**<cr>*<cr>*/<esc>ka<space>
  Arpeggio inoremap cla class<space><cr>{<cr>}<esc>2k$a
  Arpeggio inoremap req require_once<space>'';<left><left>
  Arpeggio inoremap ary array()<left>
  Arpeggio inoremap vai var_dump()<left>
  Arpeggio inoremap len strlen()<left>
endfunction

function! s:python()
  Arpeggio inoremap put print<space>
  Arpeggio inoremap fin def<space>(self):<esc>F(i
  Arpeggio inoremap ife if<space>:<left>
  Arpeggio inoremap foe for<space>i<space>in<space>:<left>
  Arpeggio inoremap els else:<cr>
  Arpeggio inoremap whi while<space>:<left>
  Arpeggio inoremap doc """<space>"""<left><left><left>
  Arpeggio inoremap cla class<space>():<left><left><left>
  Arpeggio inoremap fom from<space>
  Arpeggio inoremap imp import<space>
endfunction

function! s:common()
  Arpeggio inoremap tui true
  Arpeggio inoremap fal false
  Arpeggio inoremap mat Math
  Arpeggio inoremap wer return<space>
  Arpeggio inoremap jk <esc>
endfunction

autocmd vimenter * call s:common()
autocmd filetype php call s:php()
autocmd filetype ruby call s:ruby()
autocmd filetype python call s:python()
autocmd filetype javascript call s:javascript()
let g:arpeggio_timeoutlen=50
" }}}
" NERDTree {{{
let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinPos=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
nnoremap <leader>n :NERDTreeToggle<cr>
" }}}
" Tagbar {{{
nnoremap <leader>t :TagbarToggle<cr>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds' : [
      \   'p:package',
      \   'i:imports:1',
      \   'c:constants',
      \   'v:variables',
      \   't:types',
      \   'n:interfaces',
      \   'w:fields',
      \   'e:embedded',
      \   'm:methods',
      \   'r:constructor',
      \   'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \   't' : 'ctype',
      \   'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \   'ctype' : 't',
      \   'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }
" }}}
" JavaScript syntax {{{
let g:javascript_enable_domhtmlcss=1
let g:jsx_ext_required=0
" }}}
" Terminus {{{
let g:TerminusCursorShape=0
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
