# Source files {{{
if [ -f '/etc/zprofile' ]; then PATH=''; source '/etc/zprofile'; fi
if [ -f "$HOME/.zsh_search" ]; then source "$HOME/.zsh_search"; fi
if [ -f "$HOME/.zsh_itermshell" ]; then source "$HOME/.zsh_itermshell"; fi
if [ -d '/usr/local/share/chruby/' ]; then
  source '/usr/local/share/chruby/chruby.sh'
  source '/usr/local/share/chruby/auto.sh'
  chruby 'ruby-2.2.2'
fi
# }}}
# Export {{{
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export KEYTIMEOUT=1
if [ -d '/usr/local/node' ]; then
  export NODEPATH='/usr/local/node'
  PATH="$NODEPATH/bin:$PATH";
fi
if [ -d '/usr/local/python' ]; then
  export PYTHONPATH='/usr/local/python'
  PATH="$PYTHONPATH/bin:$PATH";
fi
if [ -d '/usr/local/go' ]; then
  export GOROOT='/usr/local/go'
  export GOPATH="$HOME/.go"
  PATH="$GOROOT/bin:$GOPATH/bin:$PATH";
fi
# }}}
# Alias {{{
alias a='ag'
alias c='clear'
alias d='df -h'
alias e='exit'
alias g='git'
alias l='ls -GFlAhp'
alias t='tmux'
alias v='vim'
alias nv='nvim'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ..='cd ../'
alias ...='cd ../../'
mcd() { mkdir -p "$1" && cd "$1"; }
trash() { mv "$@" ~/.Trash; }
# }}}
# ZSH specific settings {{{
autoload -U compinit promptinit colors vcs_info
compinit -d $HOME/.zsh_compdump
promptinit
colors
vcs_info

unsetopt beep
unsetopt correct_all
setopt correct
setopt autocd
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt menu_complete
setopt no_flowcontrol
setopt auto_menu
setopt complete_in_word
setopt complete_aliases
setopt always_to_end
setopt append_history
setopt extended_history
setopt extendedglob
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history
setopt prompt_subst
setopt long_list_jobs
setopt multios
setopt nohashdirs

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^r' history-incremental-search-backward
bindkey '^u' history-substring-search-up
bindkey '^d' history-substring-search-down

HISTFILE=$HOME/.zsh_history
HISTSIZE=1024
SAVEHIST=1024

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*:*' branchformats '%r'
zstyle ':vcs_info:*:*' formats ' %F{green}%c%u(%b)%f'
precmd() {vcs_info}
local smiley="%(?,:),:()"

PROMPT='%F{green}%B%U%1d${smiley}%u%b%f %{$reset_color%}'
RPROMPT=''
# }}}
