#!/usr/bin/env bash

function install_homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle install --file=$PWD/dot-brewrc
}

function connect_the_dots() {
  for d in dot-*; do
    dotname=${d/dot-/}
    rm -rf $HOME/.$dotname
    ln -s $PWD/$d $HOME/.$dotname
  done
}

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
elif [[ "$unamestr" == 'Darwin' ]]; then
  if [[ ! which brew ]] >/dev/null 2>&1; then
    install_homebrew
  fi
fi

read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) " reply
echo ""

case $reply in
[Yy]*) connect_the_dots ;;
[Nn]*) exit ;;
*) echo "Yes or No only" ;;
esac
