#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Packages from https://build.opensuse.org/ that will be installed via opi

opi_package=(
  #cliphist
  nwg-displays
  nwg-look
  wlogout
)

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
LOG="Install-Logs/install-$(date +'%d-%H%M%S')_opi-pkgs.log"

# Installing packages from OBS
printf "${NOTE} Installing some ${SKY_BLUE}packages from OpenSuse Builder Service (OBS)${RESET} ...\n"
for opi_pkg in "${opi_package[@]}"; do
  install_package_opi "$opi_pkg" "$LOG"
done

printf "\n%.0s" {1..2}