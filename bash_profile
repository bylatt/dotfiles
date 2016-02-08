# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# Global: {{{

if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# }}}

# Set options: {{{

stty -ixon

# }}}

# Export: {{{

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export TERM='xterm-256color'
export CLICOLOR=1
export KEYTIMEOUT=1

# Vim: {{{2

if which nvim > /dev/null 2>&1; then
  export VISUAL='nvim'
  export EDITOR='nvim'
else
  export VISUAL='vim'
  export EDITOR='vim'
fi

# }}}

# Golang: {{{2

if which go > /dev/null 2>&1; then
  export GOPATH="$HOME/Golang"
  export GOROOT="$(brew --prefix)/opt/go/libexec"
  export GOBIN="$GOPATH/bin"
  export PATH="$PATH:$GOBIN"
fi

# }}}

# }}}

# Settings: {{{

bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set show-all-if-ambiguous on'
bind 'set mark-symlinked-directories on'
bind 'set expand-tilde on'
bind 'set convert-meta off'
bind 'set input-meta on'
bind 'set output-meta on'
bind 'set visible-stats on'
bind 'set editing-mode vi'

set -o vi

shopt -s nocaseglob
shopt -s nocasematch

# }}}

# Alias: {{{

alias df='df -h'
alias ll='ls -GFlAhp'
alias lr='ls -alR'
alias cp='cp -ivR'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Vim: {{{2

if which nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
fi

# }}}

# Git: {{{2
if which hub > /dev/null 2>&1; then
  alias git='hub'
fi

# }}}

# }}}

# History: {{{

shopt -s cmdhist
shopt -s histappend
shopt -s histverify

export HISTCONTROL="erasedups:ignoredups:ignorespace"
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILESIZE=2000000

# }}}

# Title: {{{

PROMPT_COMMAND="echo -ne '\033]0;${USER}\007'"

# }}}

# Prompt: {{{

# Git: {{{2
git_branch() {
  if git rev-parse --git-dir > /dev/null 2>&1
    then echo -e "($(git branch 2> /dev/null | sed -n '/^\*/s/^\* //p')) "
  else
    echo ""
  fi
}

git_color() {
  local STATUS=`git status 2>&1`

  if [[ "$STATUS" == *'not a git repository'* ]]
    then echo ""
  else
    if [[ "$STATUS" != *'working directory clean'* ]]
      then
      # red if need to commit
      echo -e "\033[0;31m"
    else
      if [[ "$STATUS" == *'your branch is ahead'* ]]
      then
        # yellow if need to push
        echo -e "\033[0;33m"
      else
        # else cyan
        echo -e "\033[0;32m"
      fi
    fi
  fi
}

# }}}

export PS1='\[$(git_color)\]$(git_branch)\[\033[0;34m\]\W\[\033[m\] '

# }}}

# Homebrew: {{{

if which brew > /dev/null 2>&1; then

  # Chruby: {{{2

  if [ -f $(brew --prefix)/opt/chruby/share/chruby/chruby.sh ]; then
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
  fi

  # }}}

  # BashCompletion: {{{ 2

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
      source $(brew --prefix)/etc/bash_completion
    fi

  fi
  # }}}

# }}}
