" cloze2u's vim
" Plug Settings {{{
call plug#begin($HOME.'/.vim/bundle')
Plug 'ervandew/matchem'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'kana/vim-arpeggio'
Plug 'sickill/vim-pasta'
Plug 'vim-ruby/vim-ruby'
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
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
set matchtime=0
set nobackup
set nowritebackup
set noswapfile
set list
set endofline
set listchars=tab:›\ ,trail:•,extends:>,eol:\ ,nbsp:.
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
set timeout
set timeoutlen=300
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
colorscheme xoria
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
" NERDTree {{{
let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinPos=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
nnoremap <c-n> :NERDTreeToggle<cr>
" }}}
" Syntastic {{{
let g:syntastic_auto_jump=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=0
let g:syntastic_auto_loc_list=0
let g:syntastic_aggregate_errors=1
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_haml_checkers=['haml']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✠'
let g:syntastic_warning_symbol='∆'
let g:syntastic_style_warning_symbol='≈'
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
nnoremap <c-c> :SyntasticCheck<cr>
" }}}
" Arpeggio {{{
function! s:javascript()
  Arpeggio inoremap fin function<space>()<space>{<cr>}<esc>k$F(a
  Arpeggio inoremap foe .forEach(function<space>()<space>{<cr>})<esc>k$F(a
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
  Arpeggio inoremap pam .params.
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

function! s:common()
  Arpeggio inoremap tui true
  Arpeggio inoremap fal false
  Arpeggio inoremap mat Math
  Arpeggio inoremap wer return<space>
  Arpeggio inoremap jk <esc>
endfunction

autocmd vimenter * call s:common()
autocmd filetype ruby call s:ruby()
autocmd filetype javascript call s:javascript()
let g:arpeggio_timeoutlen=50
" }}}
" CtrlP {{{
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=0
let g:ctrlp_switch_buffer=0
" }}}
" JavaScript syntax {{{
let g:javascript_enable_domhtmlcss=1
let g:jsx_ext_required=0
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
" Ag {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command='ag %s --ignore-case --smart-case --skip-vcs-ignores --hidden --nocolor --nogroup -g ""'
  let g:ctrlp_use_caching=0
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif
" }}}
