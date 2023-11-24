#!/bin/bash

packman_repo="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"

# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR="$SCRIPT_DIR/.."

# Change the working directory to the parent directory of the script
cd "$PARENT_DIR" || exit 1

# Set colors for output messages
OK=$(tput setaf 2)[OK]$(tput sgr0)
ERROR=$(tput setaf 1)[ERROR]$(tput sgr0)
NOTE=$(tput setaf 3)[NOTE]$(tput sgr0)
WARN=$(tput setaf 166)[WARN]$(tput sgr0)
CAT=$(tput setaf 6)[ACTION]$(tput sgr0)
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S)_packman.log"

# Adding Packman repository and switching over to Packman
printf "\n%s - Adding Packman repository (Globally).... \n" "${NOTE}"

sudo zypper -n --quiet ar --refresh -p 90 "$packman_repo" packman 2>&1 | tee -a "$LOG"
sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"
sudo zypper -n dup --from packman --allow-vendor-change 2>&1 | tee -a "$LOG"

# Clear the terminal after execution
clear
