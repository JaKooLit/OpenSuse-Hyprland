#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Fonts Required #

fonts=(
  adobe-sourcecodepro-fonts
  fira-code-fonts
  fontawesome-fonts
  google-droid-fonts
  google-noto-sans-cjk-fonts
  google-noto-coloremoji-fonts
  liberation-fonts
  noto-sans-mono-fonts
  symbols-only-nerd-fonts
  xorg-x11-fonts-core
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_fonts.log"


# Installation of main components
printf "\n%s - Installing fonts.... \n" "${NOTE}"

for PKG1 in "${fonts[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

# Update font cache and log the output
fc-cache -v 2>&1 | tee -a "$LOG"

clear
