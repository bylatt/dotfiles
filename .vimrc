" Setting up vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/README.md'))
	sil !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'sirver/ultisnips'
Plugin 'felikz/ctrlp-py-matcher'
Plugin 'gmarik/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'docunext/closetag.vim'
Plugin 'honza/vim-snippets'
Plugin 'w0ng/vim-hybrid'
Plugin 'tommcdo/vim-exchange'
Plugin 'junegunn/vim-easy-align'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
call vundle#end()

" Settings
au!
se shm=atToOI
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
se noru nu nornu
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
se list lcs=tab:▸·,trail:·",eol:¬
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se cot=longest,menuone
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*
se stl=%F\ %{fugitive#head()}\ %=\ %Y\ LN:%l\/\%L
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100
se cole=0 cocu=i

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
let g:hybrid_use_Xresources=1
colo hybrid

" highlight the status bar when in insert mode
hi StatusLine cterm=none ctermbg=234 ctermfg=2 term=NONE guibg=#8D9247 guifg=#424242
hi CursorLine cterm=none ctermbg=none ctermfg=none term=NONE guibg=NONE guifg=NONE
hi LineNr cterm=none ctermbg=none ctermfg=235 term=NONE guibg=NONE guifg=#343435
au InsertEnter * hi StatusLine cterm=bold ctermbg=2 ctermfg=234 term=NONE guibg=#424242 guifg=#8D9247
au InsertLeave * hi StatusLine cterm=none ctermbg=234 ctermfg=2 term=NONE guibg=#8D9247 guifg=#424242

" Highlight trailing spaces in annoying red
hi ExtraWhitespace ctermbg=1
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
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
nm <cr> :nohls<cr>
nn <leader><tab> :bn<cr>
nn <leader>q :bw<cr>
nn <silent> <leader>+ :exe "res " . (winheight(0) * 3/2)<cr>
nn <silent> <leader>- :exe "res " . (winheight(0) * 2/3)<cr>

" Plugin settings
vm <cr> <plug>(EasyAlign)
nm <c-n> :NERDTreeToggle<cr>
let g:NERDTreeWinPos='right'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeHijackNetrw=1
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<c-n>'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-y>'
let g:UltiSnipsJumpBackwardTrigger='<c-m>'
let g:UltiSnipsEditSplit='vertical'
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_cache_dir=$HOME.'/.cache/ctrlp'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=0
let g:ctrlp_switch_buffer=0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|\.cache$|\DS_Store$|\node_modules$|\bower_components$'
let g:ctrlp_match_func={'match': 'pymatcher#PyMatch'}
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
