# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# Source: {{{
if [ -f ~/.zsh_search ]; then source ~/.zsh_search; fi
# }}}

# Export: {{{
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export KEYTIMEOUT=1
export HOMEBREW_GITHUB_API_TOKEN='7aab602895c13c105437d9a859f0d00aa907e0c4'
# }}}

# Rbenv: {{{
if (($+commands[rbenv])); then
  export RBENV_ROOT='/usr/local/var/rbenv'
  eval "$(rbenv init -)"
fi
# }}}

# Alias: {{{
alias df='df -h'
alias ll='ls -GFlAhp'
alias lr='ls -alR'
alias vi='vim'
alias cp='cp -ivR'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
# }}}

# Settings: {{{
autoload -U add-zsh-hook

unsetopt beep
unsetopt correct_all
unsetopt flowcontrol
setopt correct
setopt autocd
setopt auto_pushd
setopt auto_name_dirs
setopt pushd_ignore_dups
setopt auto_menu
setopt menu_complete
setopt complete_in_word
setopt complete_aliases
setopt glob_complete
setopt always_to_end
setopt extended_glob
setopt prompt_subst
setopt long_list_jobs
setopt multios
# }}}

# VCS: {{{
autoload -U vcs_info
vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' get-revision true
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks \
  git-stash \
  git-square-bracket \
  git-untracked
zstyle ':vcs_info:*' formats ":%{$fg_bold[grey]%}%m%u%c[%s:%b]%{$reset_color%}"
zstyle ':vcs_info:*' actionformats ":%{$fg_bold[grey]%}%m%u%c[%s:%b|%a]%{$reset_color%}"

add-zsh-hook precmd vcs_info
# }}}

# Autocomplete: {{{
autoload -U compinit
compinit -d ~/.zsh_compdump

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# }}}

# History: {{{
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10240
SAVEHIST=10240
# }}}

# Mapping: {{{
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^r' history-incremental-search-backward
bindkey '^u' history-substring-search-up
bindkey '^d' history-substring-search-down
# }}}

# Title: {{{
function set-window-title {
  echo -ne "\e]0;clozed2u\a"
}

add-zsh-hook precmd set-window-title
# }}}

# Prompt: {{{
autoload -U promptinit colors
promptinit
colors

PROMPT='%F{green}%B%U%1d#!%u%b%f %{$reset_color%}'
# }}}
