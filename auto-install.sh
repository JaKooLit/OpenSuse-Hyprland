#!/bin/bash
# https://github.com/JaKooLit

Distro="OpenSuse-Hyprland"
Github_URL="https://github.com/JaKooLit/$Distro.git"
Distro_DIR="$HOME/$Distro"

printf "\n%.0s" {1..1}
# Package GIT
if ! command -v git &> /dev/null
then
    echo "Git not found! Installing Git..."
    sudo zypper in -y --no-recommends git
fi

printf "\n%.0s" {1..1}

# Check if the repository already exists
if [ -d "$Distro_DIR" ]; then
    echo "$Distro_DIR exists. Updating the repository..."
    cd "$Distro_DIR"
    git stash && git pull
    chmod +x install.sh
    ./install.sh
else
    echo "$Distro_DIR does not exist. Cloning the repository..."
    git clone --depth=1 "$Github_URL" "$Distro_DIR"
    cd "$Distro_DIR"
    chmod +x install.sh
    ./install.sh
fi



