#!/bin/bash

# Install vim Vbundle
cd unix/files/.vim/bundle
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/.vim/bundle/tern_for_vim/
npm install
curl https://raw.github.com/Slava/tern-meteor/master/meteor.js > node_modules/tern/plugin/meteor.js


