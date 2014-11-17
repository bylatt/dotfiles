" Setting up Vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/autoload/vundle.vim'))
	silent !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()

" Functionality
Plugin 'raimondi/delimitmate'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'gmarik/vundle.vim'
Plugin 'docunext/closetag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mdouchement/matchit.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-dispatch'
call vundle#end()

" Settings
se nocp
se sh=/bin/zsh
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se t_ut=
se bg=dark
se et sta sw=2 ts=2 sts=2 ai si
se nowrap nospell
se bs=2
se ls=2
se smd sc ch=1
se noru nu
se cul nocuc
se novb noeb
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
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se stl=[%n]\ %t\ %y\ %M\ %=\ [%l\/\%L\ %v]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100

" highlight the status bar when in insert mode
au InsertEnter * hi StatusLine ctermbg=255 ctermfg=112
au InsertLeave * hi StatusLine ctermbg=255 ctermfg=238

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()i statusline ctermbg=0

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata-dz:h14
	se go-=m
	se go-=T
	se go-=r
	se go-=L
endif
filetype plugin indent on
syntax on
colo molokai

" Keys mapping
let mapleader=' '
let g:mapleader=' '

ino <expr> j ((pumvisible())?("\<c-n>"):("j"))
ino <expr> k ((pumvisible())?("\<c-p>"):("k"))
ino jk <esc>

nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-h> <c-w>h
nn <c-l> <c-w>l
nn <cr> :nohls<cr>

nn <tab> :bnext<cr>
nn <S-tab> :bprevious<cr>

" Per filetype settings
au filetype markdown setl nonu spell wrap

" Auto remove unwant whitespace
au BufWritePre * :%s/\s\+$//e

" Plugin settings
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-f>"
nn <leader>n :NERDTreeToggle<cr>
nn <leader>p :CtrlP<cr>
nn <leader>t :Tab /=<cr>
vn <leader>t :Tab /=<cr>
