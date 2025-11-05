#!/usr/bin/env bash
# Script has to be run from inside /dotfiles/

# sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

packages=(
	alacritty
	)

for package in ${packages[@]}; do
	sudo apt install ${package} -y
done

file=/snap/bin/nvim
if test ! -f $file; then
	sudo snap install --edge nvim --classic
fi

ln -sf "${PWD}/.alacritty.toml" "${HOME}/.alacritty.toml"

#Create symlink for .background
ln -sf "${PWD}/nvim" "${HOME}/.config/"

# update_list=$(sudo apt list --upgradable 2>/dev/null)

# echo $update_list

# if [[ sudo apt list --upgradable ]]; then
# 	sudo apt upgrade -y && sudo apt autoremove -y
# else
# 	echo "0"
# fi

# Install language servers
# npm install -g pyright

# Install JetBrainsMono Nerd font
mkdir -p ~/.local/share/fonts/jetbrains
cp -r jetbrains/ ~/.local/share/fonts/
fc-cache -f -v
