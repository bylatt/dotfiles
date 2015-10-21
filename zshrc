# Source files {{{
if [ -f '/etc/zprofile' ]; then PATH=''; source '/etc/zprofile'; fi
if [ -f "$HOME/.zsh_iterm2" ]; then source "$HOME/.zsh_iterm2"; fi
if [ -f "$HOME/.zsh_search" ]; then source "$HOME/.zsh_search"; fi
# }}}
# Export {{{
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export KEYTIMEOUT=1
export HOMEBREW_GITHUB_API_TOKEN='7aab602895c13c105437d9a859f0d00aa907e0c4'
if (($+commands[rbenv])); then
  export RBENV_ROOT="/usr/local/var/rbenv"
  eval "$(rbenv init -)"
fi
# }}}
# Alias {{{
alias df='df -h'
alias ll='ls -GFlAhp'
alias lr='ls -alR'
alias vi='vim'
alias cp='cp -ivR'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
mcd() { mkdir -p "$1" && cd "$1"; }
trash() { mv "$@" ~/.Trash; }
# }}}
# ZSH specific settings {{{
autoload -Uz add-zsh-hook compinit promptinit colors vcs_info
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
# Command from zsh-hitory-substring-search
bindkey '^u' history-substring-search-up
bindkey '^d' history-substring-search-down

HISTFILE=$HOME/.zsh_history
HISTSIZE=10240
SAVEHIST=10240

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' get-revision true
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks \
  git-stash \
  git-square-bracket \
  git-untracked
zstyle ':vcs_info:*' formats ":%{$fg_bold[grey]%}%m%u%c[%s:%b]%{$reset_color%}"
zstyle ':vcs_info:*' actionformats ":%{$fg_bold[grey]%}%m%u%c[%s:%b|%a]%{$reset_color%}"

function set-window-title {
  echo -ne "\e]0;clozed2u\a"
}

add-zsh-hook precmd set-window-title
add-zsh-hook precmd vcs_info

PROMPT='%F{green}%B%U%1d#!%u%b%f %{$reset_color%}'
# }}}
