#!/bin/bash

# Install all dependencies
pacman -S --needed base-devel linux-headers linux-lts-headers \
    nvidia-utils nvidia-settings mesa-utils nvidia-dkms \
    fish nvim less tree yazi zip unzip \
    rustup fnm lua git github-cli opencode cava \
    ttf-meslo-nerd ttf-firacode-nerd

chsh -s /usr/bin/fish

# Install the lasest stable version of Rust
rustup default stable
# Install the latest stable version of NodeJS
touch ./config/fish/completions/fnm.fish
fnm completions --shell fish > fnm.fish
fnm install --lts
fnm install --latest

# TODO: add proper pushd steps
git clone https://aur.archlinux.org/paru.git
cd paru # replace with pushd
makepkg -si
# TODO: add proper popd & clean up steps

# setup caelestia install.fish zen browser aur-helper=paru


# TODO: automate everything else...


