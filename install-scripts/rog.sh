#!/bin/bash

asusctl=(
asusctl
supergfxctl
asusctl-rog-gui
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
LOG="install-$(date +%d-%H%M%S)_rog.log"



# Set the script to exit on error
set -e

# Function for installing packages
install_package_opi() {
  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    sudo opi "$1" -n 2>&1 | tee -a "$LOG"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to install :( , please check the install.log. You may need to install manually! Sorry I have tried :("
      exit 1
    fi
  fi
}

### Install software for Asus ROG laptops ###

    printf " Installing ASUS ROG packages using opi...\n"
    for ASUS in "${asusctl[@]}"; do
	    install_package_opi  "$ASUS" 2>&1 | tee -a "$LOG"
      if [ $? -ne 0 ]; then
      echo -e "\e[1A\e[K${ERROR} - $ASUS install had failed, please check the install.log"
      exit 1
      fi
    done
    printf " Activating ROG services...\n"
    sudo systemctl enable --now supergfxd 2>&1 | tee -a "$LOG"

clear
