#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Cliphist via go ( and force installing go) #

# 16 Feb 2025 - cliphist is now added in hypr-pkgs as it is now in TW repo

cliphist=(
    go
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_cliphist.log"

# force reinstall go because on my experience it says installed but its not installing cliphist
printf "${NOTE} Installing ${SKY_BLUE}cliphist (clipboard Manager) via go${RESET} ...\n"
 for CLIP in "${cliphist[@]}"; do
   sudo zypper in -f -y "$CLIP" 2>&1 | tee -a "$LOG"
  done

# Install cliphist using go
export PATH=$PATH:/usr/local/bin
go install go.senan.xyz/cliphist@latest 2>&1 | tee -a "$LOG"

# copy cliphist into /usr/local/bin for some reason it is installing in ~/go/bin
sudo cp -r "$HOME/go/bin/cliphist" "/usr/local/bin/" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}