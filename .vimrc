" Setting up vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/README.md'))
	silent !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'felikz/ctrlp-py-matcher'
Plugin 'docunext/closetag.vim'
Plugin 'rking/ag.vim'
Plugin 'othree/html5.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
" Plugin 'fatih/vim-go'
" Plugin 'klen/python-mode'
call vundle#end()

" Settings
se nocp
se sh=/bin/zsh
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
se noru nu "rnu
se nocul nocuc
se noeb vb
se smd
se sc
se ar
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
se list lcs=tab:▸·,trail:· ",eol:¬
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se cot=longest,menuone
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*
se stl=%t\ %y\ %M\ %=\ [%l\/\%L\ %v]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100
se cole=0 cocu=i

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata\ LGC:h13
	se go-=m
	se go-=T
	se go-=r
	se go-=L
	se vb t_vb=
	se bg=dark
endif
filetype plugin indent on
syntax on
colo hemisu

" Highlight the status bar when in insert mode
if version >= 700
	hi StatusLine ctermbg=255 ctermfg=236 guibg=#ECEBEB guifg=#2A2A2A
	hi CursorLineNr cterm=bold ctermfg=11 ctermbg=255 term=bold guifg=#9C7D5E guibg=#ECEBEB
	au InsertEnter * hi StatusLine ctermbg=2 ctermfg=231 guibg=#7A9601 guifg=#FFFFFF
	au InsertLeave * hi StatusLine ctermbg=255 ctermfg=236 guibg=#ECEBEB guifg=#2A2A2A
endif

" Highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=11 guibg=#9C7D5E
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Keys mapping
let mapleader=' '
let g:mapleader=' '
ino jk <esc>
nm <c-j> <c-w>j
nm <c-k> <c-w>k
nm <c-h> <c-w>h
nm <c-l> <c-w>l
vm <  <gv
vm > >gv
nm <cr> :nohls<cr>
nn <tab> :bn<cr>
nn <S-tab> :bp<cr>
nn <leader>q :bw<cr>
nn <silent> <leader>+ :exe "res " . (winheight(0) * 3/2)<cr>
nn <silent> <leader>- :exe "res " . (winheight(0) * 2/3)<cr>

" Plugin settings
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_list_hide=&wildignore

fun! VexToggle(dir)
	if exists("t:vex_buf_nr")
		call VexClose()
	else
		call VexOpen(a:dir)
	endif
endf

fun! VexOpen(dir)
	let vex_width = 25
	execute "Vexplore " . a:dir
	let t:vex_buf_nr = bufnr("%")
	wincmd H
	call VexSize(vex_width)
endf

fun! VexClose()
	let cur_win_nr = winnr()
	let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )
	1wincmd w
	close
	unlet t:vex_buf_nr
	execute (target_nr - 1) . "wincmd w"
	call NormalizeWidths()
endf

fun! VexSize(vex_width)
	execute "vertical resize" . a:vex_width
	set winfixwidth
	call NormalizeWidths()
endf

fun! NormalizeWidths()
	let eadir_pref = &eadirection
	set eadirection=hor
	set equalalways! equalalways!
	let &eadirection = eadir_pref
endf

aug NetrwGroup
	autocmd! BufEnter * call NormalizeWidths()
aug END

no <c-n> :call VexToggle(getcwd())<CR>

vmap <cr> <plug>(EasyAlign)
let g:SuperTabDefaultCompletionType="context"
let g:ctrlp_use_caching=0
let g:ctrlp_max_files=0
let g:ctrlp_match_func={'match': 'pymatcher#PyMatch'}
let g:ctrlp_user_command='ag %s -i --nocolor --nogroup --hidden
			\ --ignore .git
			\ --ignore .svn
			\ --ignore .hg
			\ --ignore .DS_Store
			\ --ignore "**/*.pyc"
			\ -g ""'
