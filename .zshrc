# Fix path in TMUX
if [ -x /usr/libexec/path_helper ]; then
	if [ -z "$TMUX" ]; then
		eval `/usr/libexec/path_helper -s`
	fi
fi

# Export
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export PATH="$HOME/.rbenv/bin:$HOME/.nenv/bin:$HOME/.pyenv/bin:$HOME/.phpenv/bin:$PATH"

if (( $+commands[rbenv] )); then eval "$(rbenv init -)"; fi
if (( $+commands[nenv] )); then eval "$(nenv init -)"; fi
if (( $+commands[pyenv] )); then eval "$(nenv init -)"; fi
if (( $+commands[phpenv] )); then eval "$(nenv init -)"; fi

# Alias
alias ls="ls -Glah"

# ZSH specific settings
autoload -U compinit promptinit colors vcs_info
compinit -i
promptinit
colors
vcs_info

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
setopt nohashdirs

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

HISTFILE=$HOME/.zsh_history
HISTSIZE=1024
SAVEHIST=1024

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*:*' branchformats '%r'
zstyle ':vcs_info:*:*' formats ' %F{green}%c%u(%b)%f'
precmd() {vcs_info}
local smiley="%(?,:),:()"

PROMPT='%F{green}%B%U%1d%u${smiley}%b%f %{$reset_color%}'
RPROMPT=''
