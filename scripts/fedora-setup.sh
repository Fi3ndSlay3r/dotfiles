#!/bin/sh

echo -n "Provide your username\n"
read username


echo -n "Provide your github username\n"
read git_user

sudo echo max_parallel_downloads=10 >> /etc/dnf/dnf.conf
sudo defaultyes=True >> /etc/dnf/dnf.conf
sudo keepcache=True >> /etc/dnf/dnf.conf

sudo dnf update -y

sudo dnf groupupdate core

sudo hostnamectl set-hostname "napalm"

sudo dnf install -y\
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "Installing needed packages\n"
sudo dnf install -y fzf git make base-devel neovim lua openssh curl zsh cowsay\
    wget flameshot tmux alsa-utils gnome-tweaks

sudo dnf group install -y "C Development Tools and Libraries" "Development Tools"

sudo dnf groupupdate multimedia --setop="install_weak_deps=False" \
    --exclude=PackageKit-gstreamer-plugin

sudo dnf remove gnome-software PackageKit

sudo dnf groupupdate sound-and-video

flatpak install spotify com.mattjakeman.ExtensionManager

cowsay "Cloning dotfiles repo"
mkdir dev
git clone git@github.com:$git_user/dotfiles.git ~/dev/dotfiles/

cowsay "Setting up zsh"
sleep 1

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

sudo pacman -S ruby

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
gem install colorls

cd ~

cp /home/$username/dev/dotfiles/.zshrc /home/$username/.zshrc
ln /home/$username/dev/dotfiles/.zshrc /home/$username/.zshrc

cowsay "Setting up tmux"
ln ~/dev/dotfiles/.tmux.conf ~/.tmux.conf


cowsay "Setting up neovim"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

git clone git@github.com:$git_user/nvim.git /home/$username/.config/nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.neovim

nvm install node
source ~/.bashrc
cd ~/.config/nvim && nvm use node


