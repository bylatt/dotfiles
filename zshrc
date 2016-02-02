# github.com/clozed2u :: @clozed2u
# http://clozed2u.com

# History Search: {{{
# https://github.com/zsh-users/zsh-history-substring-search

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
history-substring-search-up() {
  _history-substring-search-begin
  _history-substring-search-up-history ||
  _history-substring-search-up-buffer ||
  _history-substring-search-up-search
  _history-substring-search-end
}
history-substring-search-down() {
  _history-substring-search-begin
  _history-substring-search-down-history ||
  _history-substring-search-down-buffer ||
  _history-substring-search-down-search
  _history-substring-search-end
}
zle -N history-substring-search-up
zle -N history-substring-search-down
zmodload -F zsh/parameter
if [[ $+functions[_zsh_highlight] -eq 0 ]]; then
  _zsh_highlight() {
    if [[ $KEYS == [[:print:]] ]]; then
      region_highlight=()
    fi
  }
  _zsh_highlight_bind_widgets()
  {
    zmodload zsh/zleparameter 2>/dev/null || {
      echo 'zsh-syntax-highlighting: failed loading zsh/zleparameter.' >&2
      return 1
    }
    local cur_widget
    for cur_widget in ${${(f)"$(builtin zle -la)"}:#(.*|_*|orig-*|run-help|which-command|beep|yank*)}; do
      case $widgets[$cur_widget] in
        user:$cur_widget|user:_zsh_highlight_widget_*);;
        user:*) eval "zle -N orig-$cur_widget ${widgets[$cur_widget]#*:}; \
                      _zsh_highlight_widget_$cur_widget() { builtin zle orig-$cur_widget -- \"\$@\" && _zsh_highlight }; \
                      zle -N $cur_widget _zsh_highlight_widget_$cur_widget";;
        completion:*) eval "zle -C orig-$cur_widget ${${widgets[$cur_widget]#*:}/:/ }; \
                            _zsh_highlight_widget_$cur_widget() { builtin zle orig-$cur_widget -- \"\$@\" && _zsh_highlight }; \
                            zle -N $cur_widget _zsh_highlight_widget_$cur_widget";;
        builtin) eval "_zsh_highlight_widget_$cur_widget() { builtin zle .$cur_widget -- \"\$@\" && _zsh_highlight }; \
                       zle -N $cur_widget _zsh_highlight_widget_$cur_widget";;
        *) echo "zsh-syntax-highlighting: unhandled ZLE widget '$cur_widget'" >&2 ;;
      esac
    done
  }
  _zsh_highlight_bind_widgets
fi
_history-substring-search-begin() {
  setopt localoptions extendedglob
  _history_substring_search_refresh_display=
  _history_substring_search_query_highlight=
  if [[ -z $BUFFER || $BUFFER != $_history_substring_search_result ]]; then
    _history_substring_search_query=$BUFFER
    _history_substring_search_query_escaped=${BUFFER//(#m)[\][()|\\*?#<>~^]/\\$MATCH}
    _history_substring_search_matches=(${(kOa)history[(R)(#$HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS)*${_history_substring_search_query_escaped}*]})
    _history_substring_search_matches_count=$#_history_substring_search_matches
    _history_substring_search_matches_count_plus=$(( _history_substring_search_matches_count + 1 ))
    _history_substring_search_matches_count_sans=$(( _history_substring_search_matches_count - 1 ))
    if [[ $WIDGET == history-substring-search-down ]]; then
       _history_substring_search_match_index=$_history_substring_search_matches_count
    else
      _history_substring_search_match_index=$_history_substring_search_matches_count_plus
    fi
  fi
}
_history-substring-search-end() {
  setopt localoptions extendedglob
  _history_substring_search_result=$BUFFER
  if [[ $_history_substring_search_refresh_display -eq 1 ]]; then
    region_highlight=()
    CURSOR=${#BUFFER}
  fi
  _zsh_highlight
  if [[ -n $_history_substring_search_query_highlight && -n $_history_substring_search_query ]]; then
    : ${(S)BUFFER##(#m$HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS)($_history_substring_search_query##)}
    local begin=$(( MBEGIN - 1 ))
    local end=$(( begin + $#_history_substring_search_query ))
    region_highlight+=("$begin $end $_history_substring_search_query_highlight")
  fi
  return 0
}
_history-substring-search-up-buffer() {
  local buflines XLBUFFER xlbuflines
  buflines=(${(f)BUFFER})
  XLBUFFER=$LBUFFER"x"
  xlbuflines=(${(f)XLBUFFER})
  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xlbuflines -ne 1 ]]; then
    zle up-line-or-history
    return 0
  fi
  return 1
}
_history-substring-search-down-buffer() {
  local buflines XRBUFFER xrbuflines
  buflines=(${(f)BUFFER})
  XRBUFFER="x"$RBUFFER
  xrbuflines=(${(f)XRBUFFER})
  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xrbuflines -ne 1 ]]; then
    zle down-line-or-history
    return 0
  fi
  return 1
}
_history-substring-search-up-history() {
  if [[ -z $_history_substring_search_query ]]; then
    if [[ $HISTNO -eq 1 ]]; then
      BUFFER=
    else
      zle up-line-or-history
    fi
    return 0
  fi
  return 1
}
_history-substring-search-down-history() {
  if [[ -z $_history_substring_search_query ]]; then
    if [[ $HISTNO -eq 1 && -z $BUFFER ]]; then
      BUFFER=${history[1]}
      _history_substring_search_refresh_display=1
    else
      zle down-line-or-history
    fi
    return 0
  fi
  return 1
}
_history-substring-search-not-found() {
  _history_substring_search_old_buffer=$BUFFER
  BUFFER=$_history_substring_search_query
  _history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND
}
_history-substring-search-up-search() {
  _history_substring_search_refresh_display=1
  if [[ $_history_substring_search_match_index -ge 2 ]]; then
    (( _history_substring_search_match_index-- ))
    BUFFER=$history[$_history_substring_search_matches[$_history_substring_search_match_index]]
    _history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
  elif [[ $_history_substring_search_match_index -eq 1 ]]; then
    (( _history_substring_search_match_index-- ))
    _history-substring-search-not-found
  elif [[ $_history_substring_search_match_index -eq $_history_substring_search_matches_count_plus ]]; then
    (( _history_substring_search_match_index-- ))
    BUFFER=$_history_substring_search_old_buffer
    _history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
  else
    _history-substring-search-not-found
    return
  fi
  if [[ ! -o HIST_IGNORE_ALL_DUPS && -o HIST_FIND_NO_DUPS && $BUFFER == $_history_substring_search_result ]]; then
    _history-substring-search-up-search
  fi
}
_history-substring-search-down-search() {
  _history_substring_search_refresh_display=1
  if [[ $_history_substring_search_match_index -le $_history_substring_search_matches_count_sans ]]; then
    (( _history_substring_search_match_index++ ))
    BUFFER=$history[$_history_substring_search_matches[$_history_substring_search_match_index]]
    _history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
  elif [[ $_history_substring_search_match_index -eq $_history_substring_search_matches_count ]]; then
    (( _history_substring_search_match_index++ ))
    _history-substring-search-not-found
  elif [[ $_history_substring_search_match_index -eq 0 ]]; then
    (( _history_substring_search_match_index++ ))
    BUFFER=$_history_substring_search_old_buffer
    _history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
  else
    _history-substring-search-not-found
    return
  fi
  if [[ ! -o HIST_IGNORE_ALL_DUPS && -o HIST_FIND_NO_DUPS && $BUFFER == $_history_substring_search_result ]]; then
    _history-substring-search-down-search
  fi
}

# }}}

# Export: {{{

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"
export CLICOLOR="1"
export KEYTIMEOUT="1"

# Vim: {{{2

if which nvim > /dev/null 2>&1; then
  export VISUAL="nvim"
  export EDITOR="nvim"
else
  export VISUAL="vim"
  export EDITOR="vim"
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

# Chruby: {{{

if which brew > /dev/null 2>&1; then
  if [[ -f "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh" ]]; then
    source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
    source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"

    RUBIES=(/usr/local/rubies/*)
  fi

  if [[ -f "$(brew --prefix)/etc/profile.d/z.sh" ]]; then
    source "$(brew --prefix)/etc/profile.d/z.sh"
  fi
fi

# }}}

# Alias: {{{

alias "df"="df -h"
alias "ll"="ls -GFlAhp"
alias "lr"="ls -alR"
alias "cp"="cp -ivR"
alias "mv"="mv -iv"
alias "git"="hub"
alias "mkdir"="mkdir -pv"
alias "hist"="history -1000 -1"

if which nvim > /dev/null 2>&1; then
  alias "vi"="nvim"
  alias "vim"="nvim"
fi

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

zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*:*" get-revision true
zstyle ":vcs_info:*:*" check-for-changes true
zstyle ":vcs_info:*:*" stagedstr "%F{yellow}"
zstyle ":vcs_info:*:*" unstagedstr "%F{red}"
zstyle ":vcs_info:*:*" branchformats "%r"
zstyle ":vcs_info:*:*" formats "%F{green}%m%c%u(%b)%f "
zstyle ":vcs_info:git*+set-message:*" hooks git-remote git-untracked git-stash

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

HISTCONTROL="erasedups:ignorespace"
HISTFILE=~/.zshhistory
HISTSIZE=100000
SAVEHIST=100000
HISTFILESIZE=2000000

# }}}

# Mapping: {{{

bindkey -v
bindkey -M viins "jk" vi-cmd-mode
bindkey "^r" history-incremental-search-backward
bindkey "^u" history-substring-search-up
bindkey "^d" history-substring-search-down

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

PROMPT='${vcs_info_msg_0_}%F{blue}%1~%f%{$reset_color%} '

# }}}
