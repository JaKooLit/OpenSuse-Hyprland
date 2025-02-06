#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# main dependencies #

# packages neeeded
dependencies=(
	devel_basis
)

# forced install as some reports failure that opi is not installed
opi=(
  opi
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"


# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_dependencies.log"

# Installation of main dependencies
printf "\n%s - Installing ${SKY_BLUE}main dependencies${RESET} .... \n" "${NOTE}"

for PKG1 in "${dependencies[@]}"; do
  install_package_base "$PKG1" "$LOG"
done

for PKG2 in "${opi[@]}"; do
  install_package_force "$PKG2" "$LOG"
done

printf "\n%.0s" {1..2}
