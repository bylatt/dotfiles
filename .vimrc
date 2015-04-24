" Setting up vundle
if !filereadable(expand($HOME.'/.vim/bundle/vundle.vim/README.md'))
	sil !git clone https://github.com/gmarik/vundle.vim.git $HOME/.vim/bundle/vundle.vim
en
se rtp+=$HOME/.vim/bundle/vundle.vim/
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'edsono/vim-matchit'
Plugin 'gabesoft/vim-ags'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'junegunn/vim-easy-align'
Plugin 'plasticboy/vim-markdown'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'burnettk/vim-angular'
Plugin 'mxw/vim-jsx'
call vundle#end()

" Settings
au!
se nocp
se sh=/bin/zsh
se enc=utf-8 tenc=utf-8 fenc=utf-8
se t_Co=256
se t_ut=
se t_vb=
se bg=dark
se noet sta sw=2 ts=2 sts=2 ai si
se nowrap nospell
se bs=2
se ls=2
se stal=0
se smd sc ch=1
se noru nu nornu
se cul nocuc
se noeb vb
se smd
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
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*
se stl=%F\ %{fugitive#head()}\ %*\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=\ %Y\ LN:%l\/\%L
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se cole=0 cocu=i
se clipboard+=unnamed
se history=100

" Colors and syntax
if has('gui_running')
	se gfn=Inconsolata\ LGC:h13
	se go-=m
	se go-=T
	se go-=r
	se go-=L
	se vb t_vb=
en
filet plugin indent on
syntax on
colo hemisu

" More color scheme settings
hi Normal ctermbg=none
hi NonText cterm=none ctermbg=none ctermfg=236
hi SpecialKey cterm=none ctermbg=none ctermfg=236
hi CursorLine cterm=none ctermbg=none
hi CursorLineNr cterm=none ctermbg=none
hi LineNr cterm=none ctermbg=none ctermfg=236
hi StatusLine cterm=none ctermbg=none ctermfg=148
au InsertEnter * hi StatusLine ctermbg=148 ctermfg=232
au InsertLeave * hi StatusLine ctermbg=none ctermfg=148

" Highlight trailing spaces in annoying red
hi ExtraWhitespace ctermbg=1
mat ExtraWhitespace /\s\+$/
au BufWinEnter * mat ExtraWhitespace /\s\+$/
au InsertEnter * mat ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * mat ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Keys mapping
let g:mapleader=' '
ino jk <esc>
nm <c-j> <c-w>j
nm <c-k> <c-w>k
nm <c-h> <c-w>h
nm <c-l> <c-w>l
vm <  <gv
vm > >gv
nm <cr> :noh<cr>
nn ; :
nn ! :!
nn <silent> <leader>+ :exe "res " . (winheight(0) * 3/2)<cr>
nn <silent> <leader>- :exe "res " . (winheight(0) * 2/3)<cr>

" Default vim key binding for autocomplete
" <c-x><c-o> for omnicompletion
" <c-x><c-f> for pathcompletion
" <c-x><c-l> for whole line completion
" <c-n> for next match keyword
" <c-p> for previous match keyword

" Plugin settings
vm <cr> <plug>(EasyAlign)
nm <c-n> :NERDTreeToggle<cr>
let NERDTreeHijackNetrw=1
let g:javascript_enable_domhtmlcss=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=0
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_cache_dir=$HOME.'/.cache/ctrlp'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=1
let g:ctrlp_switch_buffer=0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|\.cache$|\DS_Store$|\node_modules$|\bower_components$'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
				\ --ignore .git
				\ --ignore .svn
				\ --ignore .hg
				\ --ignore .DS_Store
				\ --ignore .cache
				\ --ignore node_modules
				\ --ignore bower_components
				\ --ignore "**/*.pyc"
				\ -g ""'
en
