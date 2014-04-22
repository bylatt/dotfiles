export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export PATH="/usr/local/git/bin:/usr/local/libtool/bin:/usr/local/automake/bin:/usr/local/autoconf/bin:/usr/local/vim/bin:/usr/local/mysql/bin:/usr/local/node/bin:$PATH"

alias ls="ls -Glah"
autoload -U compinit promptinit colors vcs_info
compinit -i
promptinit
colors

setopt no_beep
unsetopt correct_all
setopt correct
setopt auto_cd
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

#bindkey -v
#bindkey -M viins ',e' vi-cmd-mode
#bindkey -M viins '^r' history-incremental-search-backward
#bindkey -M vicmd '^r' history-incremental-search-backward

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*' branchformats '%r'
zstyle ':vcs_info:*' formats ' %F{green}%c%u%b%f'
precmd() {vcs_info}

PROMPT='$ %~/${vcs_info_msg_0_} %{$reset_color%}'
RPROMPT=''
