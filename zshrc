# Fix duplicate path in TMUX {{{
# ------------------------------
if [ -f /etc/profile ]; then
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
# ZSH substring search       {{{
# ------------------------------
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

function history-substring-search-up() {
_history-substring-search-begin
_history-substring-search-up-history ||
  _history-substring-search-up-buffer ||
  _history-substring-search-up-search
_history-substring-search-end
}

function history-substring-search-down() {
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
  function _zsh_highlight() {
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

function _history-substring-search-begin() {
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

function _history-substring-search-end() {
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

function _history-substring-search-up-buffer() {
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

function _history-substring-search-down-buffer() {
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

function _history-substring-search-up-history() {
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

function _history-substring-search-down-history() {
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

function _history-substring-search-not-found() {
_history_substring_search_old_buffer=$BUFFER
BUFFER=$_history_substring_search_query
_history_substring_search_query_highlight=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND
}

function _history-substring-search-up-search() {
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

function _history-substring-search-down-search() {
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

PROMPT='%B%F{green}%U%1d%u%f%F{cyan}${smiley}%f%b %{$reset_color%}'
RPROMPT=''
# }}}
