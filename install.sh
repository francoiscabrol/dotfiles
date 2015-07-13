#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

DOT_DIR=`pwd`
OLDDOT_DIR=$DOT_DIR/../dotfiles_old # old dotfiles backup directory

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
mkdir -p $OLDDOT_DIR

# For each os
for os in $OS_DIR; do
    os_dir="$DOT_DIR/$os"
    files="$os_dir/files"
    # Create symlinks for files
    for f in `ls -a $files`; do
        src="$files/$f"
        dest="$HOME/$f"
        copy="$OLDDOT_DIR/$f"
        create_symlink $src $dest $copy
    done
    recurciveFolders="$os_dir/recurcives"
    for f in `find $recurciveFolders -type d`; do
        src="$f"
        basename=${src/$recurciveFolders/}
        dest="$HOME$basename"
        copy="$OLDDOT_DIR$basename"
        createFolder $dest
        createFolder $copy
    done
    for f in `find $recurciveFolders -type f`; do
        src="$f"
        basename=${src/$recurciveFolders/}
        dest="$HOME$basename"
        copy="$OLDDOT_DIR$basename"
        create_symlink $src $dest $copy
    done

done

