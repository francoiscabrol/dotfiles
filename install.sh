#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

DOTVIM_HOME=`pwd`
dir=$DOTVIM_HOME                              # dotfiles directory
olddir=$DOTVIM_HOME/../dotfiles_old             # old dotfiles backup directory
files="vimrc gvimrc vim"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving dotfile ~/.$file to $olddir/$file"
    mv ~/.$file $olddir/$file
    echo "Creating symlink of $dir/$file in the home directory ~/.$file"
    ln -s $dir/$file ~/.$file
done

# install Atom
echo "Moving any existing dotfiles from ~/.atom to $olddir"
mkdir $olddir/atom
for file in $dir/atom/*
do
	name=$(basename $file)
	mv ~/.atom/$name $olddir/atom/
done
echo "Creating symlink to .atom in home directory."
ln -s $dir/atom/* ~/.atom/

# Sublime config install



#EOF
