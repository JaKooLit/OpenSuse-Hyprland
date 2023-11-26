#!/bin/bash

cliphist=(
    go
)

############## WARNING DO NOT EDIT BEYOND THIS LINE if you dont know what you are doing! ######################################
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S)_cliphist.log"

# Set the script to exit on error
set -e

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