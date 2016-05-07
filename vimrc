" github.com/clozed2u :: @clozed2u
" http://clozed2u.com

" Initialization: {{{

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb

" }}}

" Plugin: {{{

let s:dein = 0

if !isdirectory($HOME.'/.vim/bundle/repos/github.com/shougo/dein.vim')
  silent !git clone https://github.com/shougo/dein.vim.git ~/.vim/bundle/repos/github.com/shougo/dein.vim
  let s:dein = 1
endif

set runtimepath+=$HOME/.vim/bundle/repos/github.com/shougo/dein.vim
call dein#begin(expand($HOME.'/.vim/bundle'))
call dein#add('shougo/dein.vim')
call dein#add('junegunn/fzf.vim')
call dein#add('wellle/targets.vim')
call dein#add('k-takata/matchit.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('janko-m/vim-test')
call dein#add('sickill/vim-pasta')
call dein#add('alvan/vim-closetag')
call dein#add('itchyny/vim-parenmatch')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('fatih/vim-go')
call dein#add('vim-ruby/vim-ruby')
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('ecomba/vim-ruby-refactoring')
call dein#add('strogonoff/vim-coffee-script')
call dein#add('tpope/vim-rsi')
call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-commentary')

if s:dein == 1
  call dein#update()
endif

call dein#end()

filetype plugin indent on

" }}}

" Colors: {{{

set t_Co=256
set background=dark
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
set expandtab
set smarttab
set autoindent
set smartindent
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
set showtabline=0
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

set cursorline
set nocursorcolumn

set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=longest,menuone
" defualt complete=.,w,b,u,t,i
set complete-=i

set scrolloff=5
set synmaxcol=0
set fillchars+=vert:\!

" disable matchparen
let g:loaded_matchparen=1

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

  " ParenMatch: {{{2

  " Override the highlight function of the plugin
  function! parenmatch#highlight() abort
    if !get(g:, 'parenmatch_highlight', 1) | return | endif
    highlight ParenMatch ctermfg=16 ctermbg=10 cterm=bold,underline
  endfunction

  " }}}


  " FZF: {{{2

  if isdirectory('/usr/local/opt/fzf')
    set runtimepath+=/usr/local/opt/fzf

    " Just a copy->paste of Ag function to use with Pt
    function! s:pt_to_qf(line)
      let parts = split(a:line, ':')
      return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2], 'text': join(parts[3:], ':')}
    endfunction

    function! s:pt_handler(lines)
      if len(a:lines) < 2 | return | endif

      let cmd = get({'ctrl-x': 'split', 'ctrl-v': 'vertical split', 'ctrl-t': 'tabe'}, a:lines[0], 'e')
      let list = map(a:lines[1:], 's:pt_to_qf(v:val)')
      let first = list[0]
      execute cmd escape(first.filename, ' %#\')
      execute first.lnum
      execute 'normal!' first.col.'|zz'

      if len(list) > 1
        call setqflist(list)
        copen
        wincmd p
      endif
    endfunction

    command! -nargs=* Pt call fzf#run({
    \ 'source': printf('pt --home-ptignore --nogroup --column --color "%s"', escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
    \ 'sink*': function('<sid>pt_handler'),
    \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. --multi --bind ctrl-a:select-all,ctrl-d:deselect-all --color hl:68,hl+:110',
    \ 'down': '50%'
    \ })

    " Override vim default autocomplete with fzf helper
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    nnoremap <leader>p :Files<cr>
    nnoremap <leader>/ :Pt<space>
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
  autocmd BufWritePre * :%s/\s\+$//e
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
