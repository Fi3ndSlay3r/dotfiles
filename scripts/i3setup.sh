#!/bin/sh

cowsay "Installing needed packages..."
sleep 1
sudo pacman -S i3 dmenu feh imagemagick scrot xorg-xrandr playerctl redshift alsa-utils

cowsay "Installing needed fonts..."
sleep 1
yay -S ttf-font-awesome
cd ~/Downloads/ 
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir ~/.local/share/fonts
unzip Hack.zip -d HackTTF && mv HackTTF ~/.local/share/fonts/

cowsay "Setting up redshift"
sleep 1
mkdir -p ~/.config/systemd/user/
cp ~/projects/dotfiles/geoclue-agent.service ~/.config/systemd/user/
systemctl --user enable geoclue-agent.service
systemctl --user start geoclue-agent.service

cowsay "Copying i3 directory to ~/.config..."
sleep 1
cd ~/projects/dotfiles/
cp -r i3 ~/.config/

cowsay "Done :D"

