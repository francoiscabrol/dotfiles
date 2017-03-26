#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

DOT_DIR=`pwd`
OLDDOT_DIR=$HOME/tmp/dotfiles_old # old dotfiles backup directory
ignored=". .. .DS_Store"

OS_DIR="unix"
if [[ $OSTYPE == *"linux"* ]]; then
    OS_DIR="linux unix"
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_DIR="macos unix"
fi

create_symlink() {
    local src=$1
    local dest=$2
    local copy=$3
    echo "Copy from $dest to $copy"
    mv $dest $copy
    echo "Create symlink from $src to $dest"
    ln -s $src $dest
}

createFolder() {
    local src=$1
    echo "Create folder if not exist $src"
    mkdir -p $src
}

# create dotfiles_old in homedir for backup
if [[ ! -d $OLDDOT_DIR ]]; then
  rm -rf $OLDDOT_DIR
  mkdir -p $OLDDOT_DIR
fi

# For each os
for os in $OS_DIR; do
    os_dir="$DOT_DIR/$os"
    # Create symlinks for files
    files="$os_dir/files"
    for f in `ls -a $files`; do
        src="$files/$f"
        dest="$HOME/$f"
        copy="$OLDDOT_DIR/$f"
        if [[ !(${ignored[*]} =~ "$f") && ((! -f $dest && ! -d $dest) || ! -L $dest) ]]; then
          create_symlink $src $dest $copy
        fi
    done

    # Create symlinks for config
    config="$os_dir/config"
    for f in `ls -a $config`; do
        src="$config/$f"
        dest="$HOME/.config/$f"
        copy="$OLDDOT_DIR/.config/$f"
        if [[ !(${ignored[*]} =~ "$f") && ((! -f $dest && ! -d $dest) || ! -L $dest) ]]; then
          create_symlink $src $dest $copy
        fi
    done

done

