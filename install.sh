#!/bin/bash

# Install all dependencies
pacman -S --needed base-devel linux-headers linux-lts-headers \
    nvidia-utils nvidia-settings mesa-utils nvidia-dkms \
    fish nvim less tree yazi zip unzip \
    rustup nvm lua git github-cli opencode cava \
    ttf-meslo-nerd ttf-firacode-nerd

# Install the lasest stable version of Rust
rustup default stable
# Install the latest stable version of NodeJS
nvm install --lts
nvm alias default "lts/*"

# TODO: add proper pushd steps
git clone https://aur.archlinux.org/paru.git
cd paru # replace with pushd
makepkg -si
# TODO: add proper popd & clean up steps

# setup caelestia install.fish zen browser aur-helper=paru


# TODO: automate everything else...


