#!/bin/sh
#
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
#

dir=~/.dotfiles
olddir=~/.dotfiles_old
files=".zshrc .vimrc .npmrc .gemrc .irbrc .gitconfig .gitignore .hushlogin .tmux.conf"

echo "Creating $olddir for backup of any existing dotfiles in home directory"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir

for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/$file $olddir
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/$file
done
