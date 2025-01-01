#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Packages from https://build.opensuse.org/ that will be installed via opi

opi_package=(
  #cliphist
  #aylurs-gtk-shell
  nwg-look
  wlogout
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"


# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +'%d-%H%M%S')_opi-pkgs.log"

# Installing packages from OBS
printf "${NOTE} Installing packages from OpenSuse Builder Service (OBS)...\n"
for opi_pkg in "${opi_package[@]}"; do
  install_package_opi "$opi_pkg" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $opi_pkg Package installation failed, Please check the installation logs"
    exit 1
  fi
done

clear