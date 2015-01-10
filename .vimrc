" Setting up vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/README.md'))
	silent !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'talek/obvious-resize'
Plugin 'jazzcore/ctrlp-cmatcher'
Plugin 'gmarik/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'docunext/closetag.vim'
Plugin 'wellle/targets.vim'
Plugin 'andrewradev/splitjoin.vim'
Plugin 'rking/ag.vim'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
call vundle#end()

" Settings
se nocp
se sh=/bin/zsh
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se t_ut=
se t_vb=
se bg=light
se et sta sw=2 ts=2 sts=2 ai si
se nowrap nospell
se bs=2
se ls=2
se stal=0
se smd sc ch=1
se noru nu "rnu
se cul nocuc
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
se stl=[%n]\ %t\ %y\ %M\ %=\ [%l\/\%L\ %v]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100
se cole=2 cocu=i

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata\ LGC:h14
	se go-=m
	se go-=T
	se go-=r
	se go-=L
	se vb t_vb=
endif
filetype plugin indent on
syntax on
colo hemisu

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
nn <cr> :nohls<cr>
nn <tab> :bn<cr>
nn <S-tab> :bp<cr>
nn <leader>q :bw<cr>
nn <silent> <leader>+ :exe "res " . (winheight(0) * 3/2)<cr>
nn <silent> <leader>- :exe "res " . (winheight(0) * 2/3)<cr>

if version >= 700
	au InsertEnter * hi StatusLine ctermfg=255 ctermbg=64 guifg=#ffffff guibg=#608205
	au InsertLeave * hi StatusLine ctermfg=232 ctermbg=255 guifg=#000000 guibg=#eaeaea
	au BufWritePre * :%s/\s\+$//e
endif

" Plugin settings
let g:SuperTabDefaultCompletionType="context"
let g:ctrlp_use_caching=0
let g:ctrlp_user_command='ag %s -i --nocolor --nogroup --hidden
			\ --ignore .git
			\ --ignore .svn
			\ --ignore .hg
			\ --ignore .DS_Store
			\ --ignore "**/*.pyc"
			\ -g ""'
let g:ctrlp_match_func={'match': 'matcher#cmatch'}
let g:NERDTreeWinPos="right"
nn <leader>n :NERDTreeToggle<cr>
nn <leader>pf :CtrlP<cr>
nn <leader>pb :CtrlPBuffer<cr>
nn <leader>pm :CtrlPMRU<cr>
vn <leader>a :LiveEasyAlign<cr>
