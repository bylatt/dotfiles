# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

unsetopt global_rcs

# iTerm: {{{

export SSH_COMMAND=""

[[ -e $HOME/.iterm2_shell_integration.zsh ]] && source $HOME/.iterm2_shell_integration.zsh

function iterm2_print_user_vars() {
  iterm2_set_user_var sshStatus $(echo ${SSH_COMMAND})
}

# }}}

# Homebrew: {{{

export HOMEBREW=/usr/local

# }}}

# Export: {{{

  # Global: {{{2

  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
  export TERM=xterm-256color
  export CLICOLOR=1
  export KEYTIMEOUT=1
  export VISUAL=vim
  export EDITOR=vim
  export PAGER=less
  export LSCOLORS=ExFxCxDxBxegedabagacad
  export PYTHONSTARTUP=$HOME/.pythonrc

  # }}}

  # Language: {{{2

    # Go: {{{3

    if [[ -d $HOMEBREW/opt/go/libexec ]]
    then
      export GOROOT=$HOMEBREW/opt/go/libexec
      export GOPATH=$HOME/Workspace
      export GOBIN=$GOPATH/bin
      export PATH=$GOROOT/bin:$GOBIN:$PATH
    fi

    # }}}

  # }}}

# }}}

# Path: {{{

path=(
  $HOMEBREW/{bin,sbin}
  $HOME/.bin
  $HOME/.cargo/bin
  $GOROOT/bin
  $GOPATH/bin
  $path
)

# }}}

# Alias: {{{

alias vi='vim'
alias df='df -h'
alias ll='ls -GFlAhp'
alias lr='ls -alR'
alias cp='cp -ivR'
alias mv='mv -iv'
alias mkd='mkdir -pv'
alias his='history -1000 -1'
alias tmux='tmux -f $HOME/.tmuxrc'
alias flushdns='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

for method in GET POST PUT DELETE
do
  alias "$method"="curl -s -X $method"
done

# }}}

# Settings: {{{

autoload -Uz add-zsh-hook

unsetopt beep
unsetopt correct_all
unsetopt flowcontrol
setopt correct
setopt auto_cd
setopt auto_pushd
setopt auto_name_dirs
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt cdable_vars
setopt auto_menu
setopt auto_list
setopt auto_param_slash
setopt menu_complete
setopt complete_in_word
setopt complete_aliases
setopt glob_complete
setopt always_to_end
setopt extended_glob
setopt prompt_subst
setopt long_list_jobs
setopt path_dirs
setopt multios
setopt interactivecomments

# }}}

# Mapping: {{{

bindkey -v
bindkey -M viins '^p' history-substring-search-up
bindkey -M viins '^n' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^o' vi-backward-kill-word
bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^r' redo

# }}}

# VCS: {{{

autoload -Uz vcs_info
vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' get-revision true
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*:*' branchformats '%r'
zstyle ':vcs_info:*:*' formats '%F{green}%m%c%u%b%f'
zstyle ':vcs_info:*:*' actionformats '%F{green}%m%c%u%b%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-remote git-untracked git-stash

# Get name of remote that we're tracking
function +vi-git-remote() {
  local remote
  remote=$(git remote | tr '\n' '/' | sed 's/.$//' 2>/dev/null)

  if [[ -n $remote ]]; then
    # hook_com[branch]="${remote}/${hook_com[branch]}"
    hook_com[branch]="${hook_com[branch]}"
  fi
}

# Show untracked files indicator
function +vi-git-untracked() {
  local untracked
  untracked=$(git ls-files --other --exclude-standard 2>/dev/null)

  if [[ -n $untracked ]]; then
    hook_com[misc]="%F{red}"
  fi
}

# Show number of stashed changes.
function +vi-git-stash() {
local -a stashes

if [[ -s ${hook_com[base]}/.git/refs/stash ]]
then
  stashes=(${(@f)$(git stash list 2>/dev/null)})
  # Sometimes refs/stash exists even with 0 stashes
  # Make sure we have at least 1 stash before adding this info
  if (( ${#stashes} )); then
    hook_com[misc]+="${#stashes}S"
  fi
fi
}

add-zsh-hook precmd vcs_info

# }}}

# Autocomplete: {{{

autoload -Uz compinit

if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' $HOME/.zcompdump) ]
then
  compinit
else
  compinit -C
fi

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# }}}

# History: {{{

setopt append_history
setopt inc_append_history
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups

HISTCONTROL='erasedups:ignorespace'
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILESIZE=2000000

# }}}

# Title: {{{

DISABLE_AUTO_TITLE='true'

function set-window-title {
  # echo -ne "\e]0;${USER}:${PWD}\a"
  local FULL_COMMAND="$2 "
  if [[ ! -z "$FULL_COMMAND" && "$FULL_COMMAND" != "" && "$FULL_COMMAND" != " " ]]; then
    local PROCESS_NAME=${${=FULL_COMMAND}[1]}
    if [[ "$PROCESS_NAME" == "ssh" ]]; then
      export SSH_COMMAND=$(echo ${FULL_COMMAND:4:-1})
      iterm2_print_user_vars
    fi
    echo -ne "\e]0;${PROCESS_NAME}\a"
  else
    export SSH_COMMAND=""
    iterm2_print_user_vars
    echo -ne "\e]0;${USER}\a"
  fi
}

add-zsh-hook chpwd set-window-title
add-zsh-hook precmd set-window-title
add-zsh-hook preexec set-window-title

# }}}

# Prompt: {{{

autoload -Uz promptinit colors
promptinit
colors

PROMPT='%B%F{blue}%1d%f%b $ %{$reset_color%}'
RPROMPT='${vcs_info_msg_0_}'

# }}}

# Plugins: {{{

source $HOMEBREW/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# }}}

# Ensure unique path: {{{

typeset -gU cdpath fpath mailpath path

# }}}

# Funcs: {{{

work() {
  cd $HOME/Workspace/src/github.com/thothmedia/ && cd $(fd -t d -d 1 | fzy)
}

me() {
  cd $HOME/Workspace/src/github.com/clozed2u/ && cd $(fd -t d -d 1 | fzy)
}

# }}}
