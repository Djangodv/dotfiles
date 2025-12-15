#!/usr/bin/env bash
# Script has to be run from inside /dotfiles/

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

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

ln -sf "${PWD}/nvim" "${HOME}/.config/"

# Install JetBrainsMono Nerd font
# mkdir -p ~/.local/share/fonts/jetbrains
# cp -r jetbrains/ ~/.local/share/fonts/
# fc-cache -f -v
