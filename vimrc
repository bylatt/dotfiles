" NeoBundle Settings {{{
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundle 'shougo/neobundle.vim'
NeoBundle 'shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'shougo/unite.vim', {'depends': 'shougo/vimproc.vim'}
NeoBundle 'shougo/vimfiler.vim', {'depends': 'shougo/unite.vim'}
NeoBundle 'troydm/asyncfinder.vim'
NeoBundle 'troydm/easytree.vim'
NeoBundle 'vim-scripts/xoria256.vim'
NeoBundle 'vim-scripts/zoomwin'
NeoBundle 'ervandew/supertab'
NeoBundle 'ervandew/matchem'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'gabrielelana/vim-markdown'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mxw/vim-jsx', {'depends': 'pangloss/vim-javascript'}
NeoBundle 'mtscout6/vim-cjsx', {'depends': 'kchmck/vim-coffee-script'}
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
set showtabline=2
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
set listchars=tab:\ \ ,trail:\ ,extends:#,eol:\ ,nbsp:.
set fillchars=vert:\|,fold:\
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set wildmenu
set wildmode=list:longest,full
set wildignore=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*
set statusline=%1*%{getcwd()}/%2*%f\ %1*%{fugitive#head()}\ %m\ %3*%{SyntasticStatuslineFlag()}\ %1*%=\ [%l,%c]\ [%L,%p%%]
set splitbelow
set splitright
set timeoutlen=2000
set ttimeoutlen=200
set nofoldenable
set foldmethod=indent
set foldlevel=1
set concealcursor=i
set history=1000
set clipboard+=unnamed
" }}}
" Color and Syntax {{{
if has('gui_running')
  set guifont=Source\ Code\ Pro:h15
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
highlight Normal       ctermbg=none
highlight NonText      cterm=none ctermbg=none
highlight SpecialKey   cterm=none ctermbg=none
highlight CursorLine   cterm=none ctermbg=none
highlight CursorLineNr cterm=none ctermbg=none
highlight LineNr       cterm=none ctermbg=none
highlight StatusLine   cterm=none ctermbg=15  ctermfg=242
highlight StatusLineNC cterm=none ctermbg=232 ctermfg=242
highlight User1        cterm=none ctermbg=15  ctermfg=242
highlight User2        cterm=bold ctermbg=15  ctermfg=232
highlight User3        cterm=none ctermbg=15  ctermfg=1
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
inoremap jk <esc>
nnoremap ; :
nnoremap ! :!
" }}}
" Easy align {{{
vmap <enter> <plug>(EasyAlign)
" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'
" }}}
" Syntastic {{{
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
" Tagbar {{{
nnoremap <leader>t :TagbarToggle<cr>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'
" }}}
" JavaScript syntax {{{
let g:javascript_enable_domhtmlcss=1
" }}}
" Unite {{{
nnoremap <leader>p :Unite -no-split -start-insert file_rec/async:!<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>
let g:unite_source_history_yank_enable=1
let g:unite_prompt='>>> '
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
" Vimfiler {{{
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0
let g:vimfiler_tree_leaf_icon=" "
let g:vimfiler_tree_opened_icon='▾'
let g:vimfiler_tree_closed_icon='▸'
let g:vimfiler_file_icon='-'
let g:vimfiler_marked_file_icon='✓'
let g:vimfiler_readonly_file_icon='✗'
let g:vimfiler_time_format='%m-%d-%y %H:%M:%S'
let g:vimfiler_expand_jump_to_first_child=0
let g:vimfiler_ignore_pattern='\.git\|\.DS_Store\|\.pyc'

nnoremap <leader>n :<c-u>VimFilerExplorer -split -simple -parent -winwidth=35 -toggle -no-quit<cr>
nnoremap <leader>jf :<c-u>VimFilerExplorer -split -simple -parent -winwidth=35 -no-quit -find<cr>
autocmd FileType vimfiler nunmap <buffer> x
autocmd FileType vimfiler nmap <buffer> x <plug>(vimfiler_toggle_mark_current_line)
autocmd FileType vimfiler vmap <buffer> x <plug>(vimfiler_toggle_mark_selected_lines)
autocmd FileType vimfiler nunmap <buffer> l
autocmd FileType vimfiler nmap <buffer> l <plug>(vimfiler_cd_or_edit)
autocmd FileType vimfiler nmap <buffer> h <plug>(vimfiler_switch_to_parent_directory)
autocmd FileType vimfiler nunmap <buffer> <c-l>
autocmd FileType vimfiler nmap <buffer> <c-r> <plug>(vimfiler_redraw_screen)
autocmd FileType vimfiler nmap <silent><buffer><expr> <cr> vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", "\<plug>(vimfiler_edit_file)")
" }}}
" Note {{{
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
" Filetype {{{
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype zsh setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype vim setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldlevel=0
autocmd filetype php setlocal expandtab smartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=syntax
autocmd filetype ruby setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
autocmd filetype python setlocal expandtab nosmartindent shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=indent
autocmd filetype javascript setlocal expandtab smartindent shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=syntax
" }}}
