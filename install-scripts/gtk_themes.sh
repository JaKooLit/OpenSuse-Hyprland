#!/bin/bash

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
LOG="install-$(date +%d-%H%M%S)_themes.log"

set -e

# Function for installing packages
install_package() {
  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    sudo zypper in -y "$1" 2>&1 | tee -a "$LOG"
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


# installing unzip package to unzip theme packages
for PKG1 in unzip; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\033[1A\033[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

# Check if the directory exists and delete it if present
if [ -d "GTK-themes-icons" ]; then
    echo "$NOTE Tokyo Theme GTK themes and Icons folder exist..deleting..." 2>&1 | tee -a "$LOG"
    rm -rf "GTK-themes-icons" 2>&1 | tee -a "$LOG"
fi

echo "$NOTE Cloning Tokyo Theme GTK themes and Icons repository..." 2>&1 | tee -a "$LOG"
if git clone https://github.com/JaKooLit/GTK-themes-icons.git 2>&1 | tee -a "$LOG"; then
    mkdir -p ~/.icons
    mkdir -p ~/.themes
    unzip -qo "GTK-themes-icons/theme/Tokyonight-Dark-BL-LB.zip" -d ~/.themes 2>&1 | tee -a "$LOG"
    unzip -qo "GTK-themes-icons/theme/Tokyonight-Light-B-LB.zip" -d ~/.themes 2>&1 | tee -a "$LOG"
    unzip -qo "GTK-themes-icons/icon/Tokyonight-Dark-Icons.zip" -d ~/.icons 2>&1 | tee -a "$LOG"
    unzip -qo "GTK-themes-icons/icon/Tokyonight-Light-Icons.zip" -d ~/.icons 2>&1 | tee -a "$LOG"
else
    echo "$ERROR Download failed for Tokyo Theme GTK themes and Icons.." 2>&1 | tee -a "$LOG"
fi

tar -xf "assets/Bibata-Modern-Ice.tar.xz" -C ~/.icons 2>&1 | tee -a "$LOG"

clear