#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# swaylock-effects via OPI #


## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +'%d-%H%M%S')_swaylock-effects.log"

printf "${NOTE} Installing swaylock-effects using opi\n"
# Swaylock-Effects
for lock in swaylock-effects; do
  install_package_opi "$lock" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $lock install had failed, please check the install.log"
    exit 1
  fi
done

clear