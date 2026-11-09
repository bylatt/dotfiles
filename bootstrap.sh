#!/usr/bin/env bash

function install_homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle install --file=$PWD/dot-brewrc
}

function connect_the_dots() {
  for d in dot-*; do
    dotname=${d/dot-/}
    rm -rf $HOME/.$dotname
    ln -s $PWD/$d $HOME/.$dotname
  done
}

function install_herdr_plugins() {
  command -v herdr >/dev/null 2>&1 || return
  xargs -L1 -I{} herdr plugin install {} --yes <"$PWD/dot-config/herdr/plugins.txt"
}

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  echo "Linux detected"
elif [[ "$unamestr" == 'Darwin' ]]; then
  echo "MacOS detected"
  if ! command -v brew >/dev/null 2>&1; then
    install_homebrew
  fi
fi

read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) " reply
echo ""

case $reply in
[Yy]*)
  connect_the_dots
  install_herdr_plugins
  ;;
[Nn]*) exit ;;
*) echo "Yes or No only" ;;
esac
