#!/bin/bash

# Install vim Vbundle
cd unix/files/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
vim +BundleInstall +qall 2&> /dev/null
cd ../../../.



