# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# Prepare: {{{

export ZSH_CONFIG_PATH=$HOME/.zsh
export ZSH_PLUGIN_PATH=$HOME/.zsh/bundle

if [[ ! -d $ZSH_CONFIG_PATH ]]; then
  mkdir -p $ZSH_CONFIG_PATH
  mkdir -p $ZSH_PLUGIN_PATH
fi

# }}}

# Tmux: {{{

if [[ -f /etc/zprofile ]]; then
  PATH=''
  source /etc/zprofile
fi

# }}}

# Homebrew: {{{

if type brew > /dev/null; then

  # Chruby: {{{2

  if [[ -f $(brew --prefix)/opt/chruby/share/chruby/chruby.sh ]]; then
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
  fi

  # }}}

  # FZF: {{{2

  if [[ -d $(brew --prefix)/opt/fzf ]]; then
    source $(brew --prefix)/opt/fzf/shell/completion.zsh
    source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
  fi

  # }}}

else

  echo "Please install homebrew and packages list on $HOME/.homebrew\n"

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

  # }}}

  # FZF: {{{2

  has_fzf=$(type fzf)
  has_pt=$(type pt)

  if [[ has_fzf && has_pt ]]; then
    export FZF_DEFAULT_COMMAND='pt --follow --ignore-case --smart-case --home-ptignore --global-gitignore -g ""'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
  fi

  # }}}

  # Bin: {{{2

  if [[ -d $HOME/.bin ]]; then
    export PATH=$HOME/.bin:$PATH
  fi

  # }}}

  # Language: {{{2

  if type brew > /dev/null; then
    export GOROOT=$(brew --prefix)/opt/go/libexec/
    export GOPATH=$HOME/Go
    export GOBIN=$GOPATH/bin
    export PATH=$GOBIN:$PATH
  fi

  if [ -d '/usr/local/node' ]; then
    export PATH="/usr/local/node/bin:$PATH"
  fi

  if [ -d '/usr/local/php5' ]; then
    export PATH="/usr/local/php5/bin:$PATH"
  fi

  # }}}

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
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print  }'"
alias flush='dscacheutil -flushcache && killall -HUP mDNSResponder'
alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

if type hub > /dev/null; then
  alias git='hub'
fi

if type pt > /dev/null; then
  alias pt='pt --follow --ignore-case --smart-case --home-ptignore --global-gitignore'
fi

function field {
  awk "{print \$$1}"
}

function = {
  echo "$@" | bc -l
}

function up {
  if [[ "$#" -ne 1 ]]; then
    cd ..
  elif ! [[ $1 =~ '^[0-9]+$' ]]; then
    echo "Error: up should be called with the number of directories to go up. The default is 1."
  else
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
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
zstyle ':vcs_info:*:*' formats '%F{green}%m%c%u(%b) %f'
zstyle ':vcs_info:*:*' actionformats '%F{green}%m%c%u(%b) %f'
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
function +vi-git-untracked {
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
HISTFILE=$HOME/.zshhistory
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

PROMPT='${vcs_info_msg_0_}%F{242}%~%f %{$reset_color%}'
RPROMPT=''

# }}}

# Plugins: {{{

if type git > /dev/null; then
  ZSH_HISTORY_SUBSTRING_SEARCH=$ZSH_PLUGIN_PATH/zsh-history-substring-search
  if [[ ! -d $ZSH_HISTORY_SUBSTRING_SEARCH ]]; then
    echo "Installing ZSH_HISTORY_SUBSTRING_SEARCH"
    git clone -q https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_PLUGIN_PATH/zsh-history-substring-search
  fi
  source $ZSH_HISTORY_SUBSTRING_SEARCH/zsh-history-substring-search.zsh

  ZSH_COMPLETIONS=$ZSH_PLUGIN_PATH/zsh-completions
  if [[ ! -d $ZSH_COMPLETIONS ]]; then
    echo "Installing ZSH_COMPLETIONS"
    git clone -q https://github.com/zsh-users/zsh-completions.git $ZSH_PLUGIN_PATH/zsh-completions
  fi
  fpath+=($ZSH_COMPLETIONS $fpath)

  ZSH_SYNTAX_HIGHLIGHTING=$ZSH_PLUGIN_PATH/zsh-syntax-highlighting
  if [[ ! -d $ZSH_SYNTAX_HIGHLIGHTING ]]; then
    echo "Installing ZSH_SYNTAX_HIGHLIGHTING"
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGIN_PATH/zsh-syntax-highlighting
  fi
  source $ZSH_SYNTAX_HIGHLIGHTING/zsh-syntax-highlighting.zsh

  ZSH_AUTOPAIR=$ZSH_PLUGIN_PATH/zsh-autopair
  if [[ ! -d $ZSH_AUTOPAIR ]]; then
    echo "Installing ZSH_AUTOPAIR"
    git clone -q https://github.com/hlissner/zsh-autopair.git $ZSH_PLUGIN_PATH/zsh-autopair
  fi
  source $ZSH_AUTOPAIR/autopair.zsh

  ZSH_PG=$ZSH_PLUGIN_PATH/zsh-pg
  if [[ ! -d $ZSH_PG ]]; then
    echo "Installing ZSH_PG"
    git clone -q https://github.com/caarlos0/zsh-pg.git $ZSH_PLUGIN_PATH/zsh-pg
  fi
  source $ZSH_PG/pg.plugin.zsh

  ZSH_ASYNC=$ZSH_PLUGIN_PATH/zsh-async
  if [[ ! -d $ZSH_ASYNC ]]; then
    echo "Installing ZSH_ASYNC"
    git clone -q https://github.com/mafredri/zsh-async.git $ZSH_PLUGIN_PATH/zsh-async
  fi
  source $ZSH_ASYNC/async.zsh

  ZSH_FUNCTIONAL=$ZSH_PLUGIN_PATH/zsh-functional
  if [[ ! -d $ZSH_FUNCTIONAL ]]; then
    echo "Installing ZSH_FUNCTIONAL"
    git clone -q https://github.com/tarrasch/zsh-functional.git $ZSH_PLUGIN_PATH/zsh-functional
  fi
  source $ZSH_FUNCTIONAL/functional.plugin.zsh

  function update_zsh_plugin {
    local current_path
    current_path=$PWD
    cd $ZSH_PLUGIN_PATH; for plugin in `ls`; do cd $plugin; git pull origin master; cd ..; done; cd $current_path; echo "\nUpdate zsh plugins completed\n";
  }
else
  echo "Please install git to install zsh dependency\n"
fi

# }}}
