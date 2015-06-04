# Fix duplicate path in TMUX {{{
# ------------------------------
if [ -f "/etc/profile" ]; then
	PATH=""
	source /etc/profile
fi
# }}}
# Export                     {{{
# ------------------------------
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export KEYTIMEOUT=1
export PATH="$HOME/.rbenv/bin:$HOME/.pyenv/bin:$HOME/.ndenv/bin:/usr/local/php5/bin:$PATH"

if (( $+commands[rbenv] )); then eval "$(rbenv init -)"; source "$HOME/.rbenv/completions/rbenv.zsh"; fi
if (( $+commands[pyenv] )); then eval "$(pyenv init -)"; source "$HOME/.pyenv/completions/pyenv.zsh"; fi
if (( $+commands[ndenv] )); then eval "$(ndenv init -)"; source "$HOME/.ndenv/completions/ndenv.zsh"; fi
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then source "$HOME/.iterm2_shell_integration.zsh"; fi
if [ -f "$HOME/.zsh-history-substring-search.zsh" ]; then source "$HOME/.zsh-history-substring-search.zsh"; fi
# }}}
# Alias                      {{{
# ------------------------------
alias a='ag'
alias c='clear'
alias d='df -h'
alias e='exit'
alias g='git'
alias l='ls -GFlAhp'
alias t='tmux'
alias v='vim'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ..='cd ../'
alias ...='cd ../../'
mcd() { mkdir -p "$1" && cd "$1"; }
trash() { mv "$@" ~/.Trash; }
# }}}
# ZSH specific settings      {{{
# ------------------------------
autoload -U compinit promptinit colors vcs_info
compinit -d $HOME/.zsh_compdump
promptinit
colors
vcs_info

unsetopt beep
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

PROMPT='%B%F{green}%U%1d%u${smiley}%f%b %{$reset_color%}'
RPROMPT=''
# }}}
