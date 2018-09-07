#!/usr/bin/env bash

function installHomebrew() {
  bash -c 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  brew bundle install --file=$PWD/dot-brewrc
}

function linkGit() {
  rm -rf $HOME/.config/git
  mkdir -p $HOME/.config/git
  ln -s $PWD/dot-gitignore $HOME/.config/git/ignore
  ln -s $PWD/dot-gitconfig $HOME/.config/git/config
}

function makeVimDir() {
  mkdir -p $HOME/.vim/{autoload,backup,bundle,colors,tmp,undo}
}

function linkAll() {
  for d in dot-*; do
    dotname=${d/dot-/}
    rm -rf $HOME/.$dotname
    ln -s $PWD/$d $HOME/.$dotname
  done

  linkGit
  makeVimDir
}

if [ ! which brew > /dev/null 2>&1 ]; then
  installHomebrew
fi

read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  linkAll
fi

