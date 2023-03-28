#!/bin/sh

cowsay "Installing needed packages..."
sleep 1
sudo pacman -S i3 dmenu feh imagemagick scrot xorg-xrandr

cowsay "Installing needed fonts..."
sleep 1
yay -S ttf-font-awesome
cd ~/Downloads/ 
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf 
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv Meslo* ~/.local/share/fonts/

cowsay "Copying i3 directory to ~/.config..."
sleep 1
cd ~/projects/dotfiles/
cp -r i3 ~/.config/i3

cowsay "Done :D"

