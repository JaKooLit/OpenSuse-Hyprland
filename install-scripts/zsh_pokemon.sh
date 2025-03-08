#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# pokemon-color-scripts#

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_zsh_pokemon.log"

printf "${INFO} Installing ${SKY_BLUE}Pokemon color scripts${RESET} ..."

if [ -d "pokemon-colorscripts" ]; then
    cd pokemon-colorscripts && git pull && sudo ./install.sh && cd ..
    else
    git clone --depth=1 https://gitlab.com/phoneybadger/pokemon-colorscripts.git &&
    cd pokemon-colorscripts && sudo ./install.sh && cd ..
fi

# Check if ~/.zshrc exists
if [ -f "$HOME/.zshrc" ]; then
	sed -i 's|^#pokemon-colorscripts --no-title -s -r \| fastfetch -c \$HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -|pokemon-colorscripts --no-title -s -r \| fastfetch -c \$HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -|' "$HOME/.zshrc" >> "$LOG" 2>&1
	sed -i "s|^fastfetch -c \$HOME/.config/fastfetch/config-compact.jsonc|#fastfetch -c \$HOME/.config/fastfetch/config-compact.jsonc|" "$HOME/.zshrc" >> "$LOG" 2>&1
else
    echo "$HOME/.zshrc not found. Cant enable ${YELLOW}Pokemon color scripts${RESET}" >> "$LOG" 2>&1
fi

printf "\n%.0s" {1..2}
