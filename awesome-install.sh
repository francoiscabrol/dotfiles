#!/bin/bash

# Install awesome themes
cd $HOME/.config/awesome
git clone https://github.com/mikar/awesome-themes.git ./themes
rm -f $HOME/.config/awesome/themes/blackburn/theme.lua
ln -s $HOME/.config/awesome/theme.lua $HOME/.config/awesome/themes/blackburn/theme.lua
