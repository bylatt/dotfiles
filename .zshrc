# export
export LANG=en_US.utf-8
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
bindkey -v

# alias
alias ls='ls -Glah'
alias web='open -a Safari.app'
alias mail='open -a Mail.app'
alias note='open -a Notes.app'
alias todo='open -a Reminders.app'

# autoload
autoload -U compinit promptinit colors select-word-style url-quote-magic vcs_info
select-word-style bash
compinit -i
promptinit
colors

# set/unset opt
setopt no_beep
setopt correct_all
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
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt prompt_subst
setopt long_list_jobs

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*' branchformats '%r'
zstyle ':vcs_info:*' formats ' (%F{green}%c%u%b%f)'
precmd() {vcs_info}

# zmodload & zle
zmodload -i zsh/complist
zle -N self-insert url-quote-magic

PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %{$reset_color%}'
RPROMPT=''
