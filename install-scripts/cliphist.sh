#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Cliphist via go ( and force installing go) #

cliphist=(
    go
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_cliphist.log"

# force reinstall go because on my experience it says installed but its not installing cliphist
printf "${NOTE} Installing cliphist (clipboard Manager) using go...\n"
 for CLIP in "${cliphist[@]}"; do
   sudo zypper in -f -y "$CLIP" 2>&1 | tee -a "$LOG"
   [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $CLIP install had failed, please check the install.log"; exit 1; }
  done

# Install cliphist using go
export PATH=$PATH:/usr/local/bin
go install go.senan.xyz/cliphist@latest 2>&1 | tee -a "$LOG"

# copy cliphist into /usr/local/bin for some reason it is installing in ~/go/bin
sudo cp -r "$HOME/go/bin/cliphist" "/usr/local/bin/" 2>&1 | tee -a "$LOG"

clear