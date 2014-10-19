" Setting up Vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/autoload/vundle.vim'))
	silent !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/base16-vim'
Plugin 'chriskempson/base16-shell'
Plugin 'chriskempson/base16-iterm2'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'gmarik/vundle.vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/greper.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'stanangeloff/php.vim'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'justinmk/vim-sneak'
Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
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

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata-g\ for\ Powerline:h14
	se go-=mTrL
endif
filetype plugin indent on
syntax on
let base16colorspace=256
colo base16-ocean

" Keys mapping
let mapleader=','
let g:mapleader=','

ino <expr> j ((pumvisible())?("\<c-n>"):("j"))
ino <expr> k ((pumvisible())?("\<c-p>"):("k"))
ino <leader>e <esc>

nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-h> <c-w>h
nn <c-l> <c-w>l
nn <cr> :nohls<cr>

nn <tab> :bnext<cr>
nn <S-tab> :bprevious<cr>

" Per filetype settings
au filetype markdown setl nonu spell wrap

" Plugin settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-f>"
nn <leader>n :NERDTreeToggle<cr>
nn <leader>p :CtrlP<cr>
nn <leader>t :Tab /=<cr>
vn <leader>t :Tab /=<cr>
