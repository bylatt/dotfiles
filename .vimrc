" Setting up Vundle
if !filereadable(expand('~/.vim/bundle/neobundle.vim/autoload/neobundle.vim'))
	silent !git clone https://github.com/shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'shougo/vimproc.vim', {'build': {'mac' : 'make -f make_mac.mak'}}
NeoBundle 'shougo/unite.vim'
NeoBundle 'shougo/neomru.vim'
NeoBundle 'shougo/neocomplcache.vim'
NeoBundle 'shougo/neosnippet.vim'
NeoBundle 'shougo/neosnippet-snippets'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'godlygeek/tabular'
NeoBundle 'chriskempson/base16-shell'
NeoBundle 'chriskempson/base16-iterm2'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'docunext/closetag.vim'
NeoBundle 'mdouchement/matchit.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-liquid'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-dispatch'
call neobundle#end()
NeoBundleCheck

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
" se ofu=syntaxcomplete#Complete cfu=syntaxcomplete#Complete
se stl=[%n]\ %t\ %y\ %M\ %=\ [%l\/\%L\ %v]
se sb spr
se tf to tm=1000 ttm=100
se fen fdm=syntax fdl=100
se clipboard+=unnamed
se history=100

" Colors and Indent
if has('gui_running')
	se gfn=Inconsolata-g\ for\ Powerline:h14
	se go-=m
	se go-=T
	se go-=r
	se go-=L
endif
filetype plugin indent on
syntax on
let base16colorspace=256
colo base16-ocean

" Keys mapping
let mapleader=' '
let g:mapleader=' '

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

" NeoSnippet key-mappings.
imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
xmap <c-k> <Plug>(neosnippet_expand_target)
imap <expr><tab> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: pumvisible() ? "\<c-n>" : "\<tab>"
smap <expr><tab> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: "\<tab>"
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" Plugin settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline_powerline_fonts=1
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length=3
let g:neocomplcache_keyword_patterns = {}
let g:neocomplcache_force_omni_patterns = {}
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
nn <leader>p :Unite file file_rec/async<cr>
nn <leader>/ :Unite grep:.<cr>
nn <leader>y :Unite history:yank<cr>
nn <leader>b :Unite -quick-match buffer<cr>
nn <leader>t :Tab /=<cr>
vn <leader>t :Tab /=<cr>
