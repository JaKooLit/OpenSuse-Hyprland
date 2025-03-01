#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# force reinstall packages cause it says its already installed but still not
# some users report that they need to install this packages

force=(
  bc
  playerctl
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_force.log"

printf "${NOTE} ${SKY_BLUE}Force installing${RESET} some packages...\n"
 for FORCE in "${force[@]}"; do
   install_package_force "$FORCE" "$LOG"
  done

printf "\n%.0s" {1..2}