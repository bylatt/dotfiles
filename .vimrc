" Setting up vundle
if !filereadable(expand('~/.vim/bundle/vundle.vim/README.md'))
	sil !git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
endif
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#begin()
Plugin 'raimondi/delimitmate'
Plugin 'sirver/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'felikz/ctrlp-py-matcher'
Plugin 'gmarik/vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'docunext/closetag.vim'
Plugin 'othree/html5.vim'
Plugin 'chriskempson/tomorrow-theme'
Plugin 'justinmk/vim-sneak'
Plugin 'honza/vim-snippets'
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
se noru nu nornu
se nocul nocuc
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
se list lcs=tab:▸·,trail:· ",eol:¬
se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se cot=longest,menuone
se wmnu wim=list:longest,full wig=*.png,*.jpg,*gif,*DS_Store*,*.gem,*sass-cache*,*/tmp/*,*node_modules*,*bower_components*
se stl=%F\ %{fugitive#head()}\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=\ %Y\ LN:%l\/\%L
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
colo tomorrow

" More theme settings
" hi StatusLine cterm=NONE ctermbg=NONE
" hi CursorLine cterm=NONE
" hi LineNr cterm=NONE ctermbg=NONE ctermfg=252
" hi SpecialKey cterm=NONE ctermbg=NONE ctermfg=252
hi Normal ctermbg=NONE

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
nm <leader><cr> :nohls<cr>
nn <leader><tab> :bn<cr>
nn <leader>q :bw<cr>
nn <silent> <leader>+ :exe "res " . (winheight(0) * 3/2)<cr>
nn <silent> <leader>- :exe "res " . (winheight(0) * 2/3)<cr>
" <c-x><c-o> for omnicompletion
" <c-x><c-f> for pathcompletion
" <c-n> for next match keyword
" <c-p> for previous match keyword

" Plugin settings
vm <cr> <plug>(EasyAlign)
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-y>'
let g:UltiSnipsJumpBackwardTrigger='<c-m>'
let g:UltiSnipsEditSplit='vertical'
let g:syntastic_enable_signs=0
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_cache_dir=$HOME.'/.cache/ctrlp'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=1
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
