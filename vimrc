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

highlight Normal                  ctermbg=NONE
highlight NonText      cterm=NONE ctermbg=NONE
highlight SpecialKey   cterm=NONE ctermbg=NONE
highlight CursorLine   cterm=NONE ctermbg=NONE guibg=NONE
highlight CursorLineNr cterm=BOLD ctermbg=NONE guibg=NONE
highlight LineNr       cterm=NONE ctermbg=NONE guibg=NONE

" }}}

" Vundle: {{{

filetype off

set runtimepath+=~/.vim/bundle/vundle.vim

call vundle#begin()

Plugin 'vundlevim/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'sickill/vim-pasta'
Plugin 'janko-m/vim-test'
Plugin 'kana/vim-arpeggio'
Plugin 'pangloss/vim-javascript'
Plugin 'rhysd/vim-crystal'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'

call vundle#end()

filetype plugin indent on

" }}}

" Settings: {{{

" Specific shell
set shell=$SHELL
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

set foldenable
set foldmethod=indent
set foldlevel=9999

set cursorline
set nocursorcolumn

set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" }}}

" Status Line: {{{

" Status Function: {{{2

function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let stat = ''

  " this function just outputs the content colored by the
  " supplied colorgroup number, e.g. num = 2 -> User2
  " it only colors the input if the window is the currently
  " focused one

  function! Color(active, group, content)
    if a:active
      return '%#' . a:group . '#' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " this handles alternative statuslines
  let usealt = 0

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  let altstat = ''

  if type ==# 'help'
    let altstat .= '%#SLHelp# HELP %* ' . fnamemodify(name, ':t:r')
    let usealt = 1
  endif

  if usealt
    return altstat
  endif

  " column
  "   this might seem a bit complicated but all it amounts to is
  "   a calculation to see how much padding should be used for the
  "   column number, so that it lines up nicely with the line numbers

  "   an expression is needed because expressions are evaluated within
  "   the context of the window for which the statusline is being prepared
  "   this is crucial because the line and virtcol functions otherwise
  "   operate on the currently focused window

  function! Column()
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)]) + &l:foldcolumn
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''

    if padding <= 0
      let column .= vc
    else
      let column .= repeat(' ', padding + 1) . vc
    endif

    return column . ' '
  endfunction

  let stat .= '%#SLColumn#'
  let stat .= '%{Column()}'
  let stat .= '%*'

  if getwinvar(a:winnum, 'statusline_progress', 0)
    let stat .= Color(active, 'SLProgress', ' %p ')
  endif

  " file name
  let stat .= Color(active, 'SLArrows', active ? '' : '')
  let stat .= ' %<'
  let stat .= '%f'
  let stat .= ' ' . Color(active, 'SLArrows', active ? '' : '')

  " file modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= Color(active, 'SLLineNr', modified ? ' +' : '')

  " read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= Color(active, 'SLLineNR', readonly ? ' ‼' : '')

  " paste
  if active
    if getwinvar(a:winnum, '&spell')
      let stat .= Color(active, 'SLLineNr', ' S')
    endif

    if getwinvar(a:winnum, '&paste')
      let stat .= Color(active, 'SLLineNr', ' P')
    endif
  endif

  " right side
  let stat .= '%='

  " git branch
  if exists('*fugitive#head')
    let head = fugitive#head()

    if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
      call fugitive#detect(getcwd())
      let head = fugitive#head()
    endif
  endif

  if !empty(head)
    let stat .= Color(active, 'SLBranch', ' ← ') . head . ' '
  endif

  return stat
endfunction

" }}}

" Status AutoCMD: {{{

function! s:ToggleStatusProgress()
  if !exists('w:statusline_progress')
    let w:statusline_progress = 0
  endif

  let w:statusline_progress = !w:statusline_progress
endfunction

command! ToggleStatusProgress :call s:ToggleStatusProgress()

nnoremap <silent> ,p :ToggleStatusProgress<CR>

function! s:IsDiff()
  let result = 0

  for nr in range(1, winnr('$'))
    let result = result || getwinvar(nr, '&diff')

    if result
      return result
    endif
  endfor

  return result
endfunction

function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

command! RefreshStatus :call <SID>RefreshStatus()

augroup status
  autocmd!
  autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * :RefreshStatus
augroup END

" }}}

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
inoremap <c-u> <c-w>

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
  autocmd filetype sh setlocal foldmethod=marker foldlevel=0
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

let g:ctrlp_by_filename=0
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_files=0
let g:ctrlp_cache_dir='~/.vim/tmp/ctrlp'

if executable('ag')
  let g:ctrlp_user_command='ag %s --ignore-case --smart-case --skip-vcs-ignores --hidden --nocolor --nogroup -g ""'
  let g:ctrlp_use_caching=0
endif

" }}}

" Syntastic: {{{2

let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list=0
let g:syntastic_aggregate_errors=1
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
nnoremap <c-c> :SyntasticCheck<cr>

" }}}

" Test: {{{2

let g:test#strategy='basic'
let g:test#preserve_screen=1
nmap <silent> <leader>t :TestNearest<cr>
nmap <silent> <leader>f :TestFile<cr>
nmap <silent> <leader>a :TestSuite<cr>
nmap <silent> <leader>l :TestLast<cr>
nmap <silent> <leader>g :TestVisit<cr>

" }}}

" }}}

" Local config: {{{

set exrc
set secure

" }}}

" Arpeggio: {{{
function! s:javascript()
  Arpeggio inoremap fin function<space>
  Arpeggio inoremap con console.log
  Arpeggio inoremap thi this
  Arpeggio inoremap ten .then
  Arpeggio inoremap req require('')<left><left>
  Arpeggio inoremap vai var<space>
  Arpeggio inoremap let let<space>
  Arpeggio inoremap don document.
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
  Arpeggio inoremap ofe .forEach(<space>function<space>()<space>{})<left><left>
endfunction

function! s:ruby()
  Arpeggio inoremap put puts<space>
  Arpeggio inoremap xv, cases do<cr>end<esc>O<tab>
  Arpeggio inoremap xv. loop do<cr>end<esc>O<tab>
  Arpeggio inoremap req require ''<left>
  Arpeggio inoremap whi while<cr>end<esc>kA<space>
  Arpeggio inoremap fin def<cr>end<esc>kA<space>
  Arpeggio inoremap cla class<space><cr>end<esc>k$a
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
  Arpeggio inoremap don /**<cr>*<cr>*/<esc>ka<space>
  Arpeggio inoremap cla class<space><cr>{<cr>}<esc>2k$a
endfunction

function! s:common()
  Arpeggio inoremap tui true
  Arpeggio inoremap fal false
  Arpeggio inoremap mat Math
  Arpeggio inoremap ren return<space>
endfunction

autocmd vimenter * call s:common()
autocmd filetype php call s:php()
autocmd filetype ruby call s:ruby()
autocmd filetype javascript call s:javascript()
let g:arpeggio_timeoutlen=30

" }}}

" Macvim: {{{

if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guifont=Inconsolata\ LGC:h14
endif

" }}}

" Note: {{{

"" Default vim key binding for autocomplete
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
"" When stage is on option list
" <c-n> for next option
" <c-p> for previous option

" }}}
