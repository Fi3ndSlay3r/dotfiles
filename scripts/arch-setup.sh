#!/bin/sh

echo -n "Provide your username"
read username

echo -e "Installing needed packages\n"
sudo pacman -Sy fzf git make base-devel neovim lua openssh curl zsh cowsay wget flameshot tmux xdg-desktop-portal alsa-utils picom

cowsay "Setting up yay"
sleep 1
cd /home/$username
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -Syu spotify visual-studio-code-bin chromium


cowsay "Cloning dotfiles repo"
mkdir projects
git clone git@github.com:fr-EDD1E/dotfiles.git ~/projects/dotfiles/

cowsay "Setting up zsh"
sleep 1

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

sudo pacman -S ruby

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
gem install colorls

cd ~

cp /home/$username/projects/dotfiles/.zshrc /home/$username/.zshrc
ln /home/$username/projects/dotfiles/.zshrc /home/$username/.zshrc

cowsay "Setting up tmux"
ln ~/projects/dotfiles/.tmux.conf ~/.tmux.conf


cowsay "Setting up neovim"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

git clone git@github.com:fr-EDD1E/nvim.git /home/$username/.config/nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.neovim

nvm install node
source ~/.bashrc
cd ~/.config/nvim && nvm use node


