# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# Prepare: {{{
# }}}

# Tmux: {{{

if [[ -f /etc/zprofile ]]; then
  PATH=''
  source /etc/zprofile
fi

# }}}

# Homebrew: {{{

export HOMEBREW=`brew --prefix`
if [[ -d $HOMEBREW/sbin ]]; then
  export PATH=$HOMEBREW/sbin:$PATH
fi
if [[ -d $HOME/.android-platform-tools ]]; then
  export PATH=$HOME/.android-platform-tools:$PATH
fi

# }}}

# Export: {{{

  # Global: {{{2

  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export TERM=xterm-256color
  export CLICOLOR=1
  export KEYTIMEOUT=1
  export VISUAL=vim
  export EDITOR=vim
  export LSCOLORS=ExFxCxDxBxegedabagacad

  # }}}

  # Bin: {{{2

  if [[ -d $HOME/.bin ]]; then
    export PATH=$HOME/.bin:$PATH
  fi

  # }}}

  # Language: {{{2

    # Go: {{{3

    if [[ -d $HOMEBREW/opt/go/libexec ]]; then
      export GOROOT=$HOMEBREW/opt/go/libexec
      export GOPATH=$HOME/Workspace
      export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
    fi

    # }}}

  # }}}

# }}}

# Alias: {{{

alias vi='vim'
alias vim='vim'
alias df='df -h'
alias ll='ls -GFlAhp'
alias lr='ls -alR'
alias cp='cp -ivR'
alias mv='mv -iv'
alias mkd='mkdir -pv'
alias his='history -1000 -1'
alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder'
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

for method in GET POST PUT DELETE; do
  alias "$method"="curl -s -X $method"
done

function work() {
  cd `find $HOME/Workspace/src/github.com/thothmedia -type d -maxdepth 1 | pick`
}

# }}}

# Settings: {{{

autoload -U add-zsh-hook

unsetopt beep
unsetopt correct_all
unsetopt flowcontrol
setopt correct
setopt auto_cd
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

autoload -U vcs_info
vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' get-revision true
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*:*' branchformats '%r'
zstyle ':vcs_info:*:*' formats '%F{green}%m%c%u%b %f'
zstyle ':vcs_info:*:*' actionformats '%F{green}%m%c%u%b %f'
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

if [[ -s ${hook_com[base]}/.git/refs/stash ]]; then
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

autoload -U compinit
compinit -d $HOME/.zshcompdump

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

HISTCONTROL='erasedups:ignorespace'
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILESIZE=2000000

# }}}

# Title: {{{

function set-window-title {
  echo -ne "\e]0;${USER}\a"
}

add-zsh-hook precmd set-window-title

# }}}

# Prompt: {{{

autoload -U promptinit colors
promptinit
colors

# PROMPT='%F{blue}%1d%f%F{250} ϟϟ%f %{$reset_color%}'
PROMPT='%F{blue}%1d%f %B%F{red}❯%f%F{yellow}❯%f%F{green}❯%f%b %{$reset_color%}'
RPROMPT='${vcs_info_msg_0_}'

# }}}

# Plugins: {{{

source $HOMEBREW/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

# }}}
