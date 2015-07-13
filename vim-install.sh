# Install vim Vbundle
cd unix/files/.vim/bundle
git clone git@github.com:VundleVim/Vundle.vim.git
vim +BundleInstall +qall 2&> /dev/null
cd YouCompleteMe
./install.sh --clang-completer
cd $DOT_DIR



