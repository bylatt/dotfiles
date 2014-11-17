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
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/vim/bin:$PATH"
export PATH="/usr/local/tmux/bin:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH="/usr/local/sqlite/bin:$PATH"
export PATH="/usr/local/mysql/bin:/usr/local/mysql/support-files:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib"
export PATH="/usr/local/postgresql/bin:$PATH"
export PATH="/usr/local/redis/bin:$PATH"
export PATH="/usr/local/mongodb/bin:$PATH"
export PATH="/usr/local/php5/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nenv/bin:$PATH"

# If rbenv install load it
if (( $+commands[rbenv] )); then
	eval "$(rbenv init -)"
fi

# If nenv install load it
if (( $+commands[nenv] )); then
	eval "$(nenv init -)"
fi

# Alias
alias ls="ls -Gflash"
alias vi="vim"
alias psql_start="pg_ctl -D /usr/local/var/db/postgresql -l /usr/local/var/log/postgresql/logfile.log start"
alias psql_stop="pg_ctl -D /usr/local/var/db/postgresql stop"
alias mongo_start="mongod --config=/usr/local/mongodb/mongodb.conf"
alias mongo_stop="killall mongod"
alias redis_start="redis-server /usr/local/redis/redis.conf"
alias redis_stop="killall redis-server"

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
HISTSIZE=1000
SAVEHIST=1000

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

# PROMPT='%~${vcs_info_msg_0_} %{$reset_color%}'
PROMPT='%F{green}%n%f %F{yellow}○%f %{$reset_color%}'
RPROMPT='%F{red}%d%f'
