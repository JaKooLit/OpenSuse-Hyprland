#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# pokemon-color-scripts#

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_zsh_pokemon.log"

printf "${INFO} Installing ${SKY_BLUE}Pokemon color scripts${RESET} ..."

if [ -d "pokemon-colorscripts" ]; then
    cd pokemon-colorscripts && git pull && sudo ./install.sh && cd ..
    else
    git clone --depth 1 https://gitlab.com/phoneybadger/pokemon-colorscripts.git &&
    cd pokemon-colorscripts && sudo ./install.sh && cd ..
fi

# Check if ~/.zshrc exists
if [ -f "$HOME/.zshrc" ]; then
    sed -i '/#pokemon-colorscripts --no-title -s -r/s/^#//' "$HOME/.zshrc" >> "$LOG" 2>&1
    sed -i '/^fastfetch -c $HOME\/.config\/fastfetch\/config-compact.jsonc/s/^/#/' "$HOME/.zshrc" >> "$LOG" 2>&11
else
    echo "$HOME/.zshrc not found. Cant enable ${YELLOW}Pokemon color scripts${RESET}" >> "$LOG" 2>&1
fi
  
printf "\n%.0s" {1..2}
