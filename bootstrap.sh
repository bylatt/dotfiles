#!/usr/bin/env bash

function install_homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle install --file=$PWD/dot-brewrc
}

function symlink_git() {
  rm -rf $HOME/.config/git
  mkdir -p $HOME/.config/git
  ln -s $PWD/dot-gitignore $HOME/.config/git/ignore
  ln -s $PWD/dot-gitconfig $HOME/.config/git/config
}

function make_vim_dir() {
  mkdir -p $HOME/.vim/{autoload,backup,bundle,colors,tmp,undo,pack}
}

function symlink_vim_to_neovim() {
  mkdir -p $HOME/.config
  ln -s $HOME/.vim $HOME/.config/nvim
  ln -s $PWD/dot-vimrc $HOME/.config/nvim/init.vim
}

function connect_the_dots() {
  for d in dot-*; do
    dotname=${d/dot-/}
    rm -rf $HOME/.$dotname
    ln -s $PWD/$d $HOME/.$dotname
  done

  symlink_git
  make_vim_dir
  symlink_vim_to_neovim
}

if [ ! which brew > /dev/null 2>&1 ]; then
  install_homebrew
fi

read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) " reply
echo ""

case $reply in
  [Yy]* ) connect_the_dots;;
  [Nn]* ) exit;;
  * ) echo "Yes or No only";;
esac
