# Install awesome themes
cd $HOME/.config/awesome
git clone git@github.com:mikar/awesome-themes.git ./themes
rm -f $HOME/.config/awesome/themes/blackburn/theme.lua
ln -s $HOME/.config/awesome/theme.lua $HOME/.config/awesome/themes/blackburn/theme.lua
