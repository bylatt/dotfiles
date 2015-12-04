# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# History Search: {{{

if [ -f "$HOME/.zshsearch" ]; then
  source "$HOME/.zshsearch"
  bindkey "^u" history-substring-search-up
  bindkey "^d" history-substring-search-down
fi

# }}}

# Export: {{{

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export VISUAL=vim
export EDITOR=vim
export CLICOLOR=1
export KEYTIMEOUT=1

# }}}

# Chruby: {{{

if which brew > /dev/null 2>&1; then
  if [[ -f "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh" ]]; then
    source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
    source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"
  fi
fi

# }}}

# Alias: {{{

alias df="df -h"
alias ll="ls -GFlAhp"
alias lr="ls -alR"
alias vi="vim"
alias cp="cp -ivR"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias hist="history -1000 -1"

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

# Get name of remote that we're tracking
function +vi-git-remote() {
  local remote
  remote=$(git remote 2>/dev/null)
  if [[ -n ${remote} ]]; then
    hook_com[branch]="${remote}/${hook_com[branch]}"
  fi
}

# Show untracked files indicator
function +vi-git-untracked {
  local untracked
  untracked=$(git ls-files --other --exclude-standard 2>/dev/null)
  if [[ -n ${untracked} ]]; then
    hook_com[misc]+="[?]"
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
      hook_com[misc]+="[${#stashes}S]"
    fi
  fi
}

# Square bracketing for a few things
function +vi-git-square-bracket {
  if [[ -n ${hook_com[unstaged]} ]]; then
    hook_com[unstaged]="[${hook_com[unstaged]}]"
  fi

  if [[ -n ${hook_com[staged]} ]]; then
    hook_com[staged]="[${hook_com[staged]}]"
  fi
}

add-zsh-hook precmd vcs_info

# Show git info in the right prompt
RPROMPT='${vcs_info_msg_0_}'

# }}}

# Autocomplete: {{{

autoload -U compinit
compinit -d ~/.zshcompdump

zstyle ":completion::complete:*" use-cache on
zstyle ":completion:*" cache-path ~/.cache/zsh
zstyle ":completion:*" completer _expand _complete _ignored _approximate
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zstyle ":completion:*" menu select
zstyle ":completion:*:cd:*" tag-order local-directories directory-stack path-directories

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

HISTFILE=~/.zshhistory
HISTSIZE=4096
SAVEHIST=4096

# }}}

# Mapping: {{{

bindkey -v
bindkey -M viins "jk" vi-cmd-mode
bindkey "^r" history-incremental-search-backward

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

PROMPT="%F{green}%U%B%1d#!%b%u%f%{$reset_color%} "

# }}}
