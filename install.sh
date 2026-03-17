#!/bin/bash

# Install all dependencies
pacman -S --needed base-devel linux-headers linux-lts-headers \
    nvidia-utils nvidia-settings mesa-utils nvidia-dkms \
    fish nvim less tree yazi zip unzip \
    rustup mise lua git github-cli opencode cava \
    ttf-meslo-nerd ttf-firacode-nerd

chsh -s /usr/bin/fish

# TODO: automate copying .config

# Install the latest stable versions:
mise install

# TODO: add proper pushd steps
git clone https://aur.archlinux.org/paru.git
cd paru # replace with pushd
makepkg -si
# TODO: add proper popd & clean up steps

# setup caelestia install.fish zen browser aur-helper=paru


# TODO: automate everything else...


