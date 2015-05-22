" NeoBundle Settings            {{{
" ---------------------------------
se rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundleFetch 'shougo/neobundle.vim'
NeoBundle 'shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'shougo/unite.vim'
NeoBundle 'goatslacker/mango.vim'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'ervandew/supertab'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'kana/vim-arpeggio', {'build': {'unix': 'make'}}
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'fatih/vim-go'
call neobundle#end()
" }}}
" Vim Settings                  {{{
" ---------------------------------
se nocp
se sh=$SHELL
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se t_ut=
se t_vb=
se bg=dark
se et sta sw=2 ts=2 sts=2 ai si
se nowrap nospell
se bs=2
se ls=2
se stal=0
se smd sc ch=1
se noru nu nornu
se cul nocuc
se noeb vb
se sc
se ar aw
se hid
se bin
se noeol
se so=4
se gd
se is scs ic hls inf
se sm mat=10
se ws
se magic
se nobk nowb noswf
se list lcs=tab:\ \ ,trail:\  ",eol:\
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se cot=longest,menuone
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*,*vendor*
se stl=%1*%{getcwd()}/%2*%f\ %1*%{fugitive#head()}\ %m\ %3*%{SyntasticStatuslineFlag()}\ %1*%=\ →\ %Y
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=10
se cole=0 cocu=i
se history=100
se clipboard+=unnamed
"" }}}
" Color and Syntax              {{{
" ---------------------------------
if has('gui_running')
  se gfn=Inconsolata\ LGC:h15
  se go-=m
  se go-=T
  se go-=r
  se go-=L
en
filet plugin indent on
syntax on
colo mango
" }}}
" Improve color scheme          {{{
" ---------------------------------
hi Normal ctermbg=none
hi MatchParen cterm=bold
hi TabLineSel cterm=bold
hi Title cterm=bold
hi DiffText cterm=bold
hi DiffDelete cterm=bold
hi Keyword cterm=bold
hi Todo cterm=bold
hi Function cterm=bold
hi Statement cterm=bold
hi Type cterm=bold
hi ErrorMsg cterm=bold
hi VisualNOS cterm=bold,underline
hi NonText cterm=bold ctermbg=none ctermfg=236
hi SpecialKey cterm=none ctermbg=none ctermfg=236
hi CursorLine cterm=none ctermbg=none
hi CursorLineNr cterm=none ctermbg=none
hi LineNr cterm=none ctermbg=none ctermfg=240
hi IncSearch cterm=bold ctermbg=220 ctermfg=236
hi StatusLine cterm=none ctermbg=15 ctermfg=246
hi StatusLineNC cterm=none ctermbg=none ctermfg=232
hi User1 cterm=none ctermbg=15 ctermfg=246
hi User2 cterm=bold ctermbg=15 ctermfg=232
hi User3 cterm=none ctermbg=15 ctermfg=1
" }}}
" Keys mapping                  {{{
" ---------------------------------
let g:mapleader=' '
nm <c-j> <c-w>j
nm <c-k> <c-w>k
nm <c-h> <c-w>h
nm <c-l> <c-w>l
vm <  <gv
vm > >gv
nm <cr> :noh<cr>
nn ; :
nn ! :!
" }}}
" Netrw settings                {{{
" ---------------------------------
fu! VexToggle(dir)
  if exists("t:vex_buf_nr")
    cal VexClose()
  el
    cal VexOpen(a:dir)
  en
endf

fu! VexOpen(dir)
  let g:netrw_browse_split = 4
  let vex_width = 30
  exe "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H
  cal VexSize(vex_width)
endf

fu! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )
  1wincmd w
  clo
  unl t:vex_buf_nr
  execute (target_nr - 1) . "wincmd w"
  cal NormalizeWidths()
endf

fu! VexSize(vex_width)
  exe "vertical resize" . a:vex_width
  se winfixwidth
  cal NormalizeWidths()
endf

fu! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

aug NetrwGroup
  au! BufEnter * cal NormalizeWidths()
aug END

let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_list_hide=&wildignore

no <leader>n :call VexToggle(getcwd())<CR>
" }}}
" Arpeggio setup                {{{
" ---------------------------------
let g:arpeggio_timeoutlen=100

fu! s:ArpeggioDefault()
  Arpeggio ino jk <esc>
endf

fu! s:ArpeggioInit()
  call s:ArpeggioDefault()
endf

au vimenter * call s:ArpeggioInit()
" }}}
" EasyAlign setup               {{{
" ---------------------------------
vm <cr> <plug>(EasyAlign)
" }}}
" Syntastic setup               {{{
" ---------------------------------
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=0
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_haml_checkers=['haml']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_python_checkers=['python', 'flake8']
" }}}
" JavaScript syntax setup       {{{
" ---------------------------------
let g:javascript_enable_domhtmlcss=1
" }}}
" Unite setup                   {{{
" ---------------------------------
nn <leader>p :Unite -no-split -start-insert file_rec/async:!<cr>
nn <leader>y :Unite history/yank<cr>
nn <leader>s :Unite -quick-match buffer<cr>
nn <leader>/ :Unite grep:.<cr>
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
en

fu! s:unite_settings()
  im <buffer> <esc> <plug>(unite_exit)
  im <buffer> <c-j> <plug>(unite_select_next_line)
  im <buffer> <c-k> <plug>(unite_select_previous_line)
endf

au filetype unite call s:unite_settings()
" }}}
" Note                          {{{
" ---------------------------------
" Default vim key binding for autocomplete
" <c-x><c-o> for omnicompletion
" <c-x><c-f> for pathcompletion
" <c-x><c-l> for whole line completion
" <c-n> for next match keyword
" <c-p> for previous match keyword
" }}}
" Filetype                      {{{
" ---------------------------------
au filetype * setl fo-=c fo-=r fo-=o
au filetype zsh setl et si sw=2 ts=2 sts=2 fdm=marker fdl=0
au filetype vim setl et si sw=2 ts=2 sts=2 fdm=marker fdl=0
au filetype php setl et si sw=2 ts=2 sts=2 fdm=syntax
au filetype ruby setl et si sw=2 ts=2 sts=2 fdm=syntax
au filetype python setl et nosi sw=4 ts=4 sts=4 fdm=syntax
" }}}
