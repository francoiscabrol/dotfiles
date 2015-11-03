#!/bin/bash

# Install vim Vbundle
cd unix/files/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
vim +BundleInstall +qall 2&> /dev/null
cd ~/.vim/bundle/tern_for_vim/
npm install
curl https://raw.github.com/Slava/tern-meteor/master/meteor.js > node_modules/tern/plugin/meteor.js


