#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# adding additional repo

#All of Packman
packman_repo="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"

# Only Essentials
packman_essentials="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/"
                  
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_add-repo.log"

# Check if Packman repository already in system
if ! sudo zypper repos | grep -q 'packman'; then
  printf "\n%s - Adding ${SKY_BLUE}Packman repository (Globally)${RESET} .... \n" "${NOTE}"

  sudo zypper -n --quiet ar --refresh -p 90 "$packman_repo" packman 2>&1 | tee -a "$LOG"
  sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"
  sudo zypper -n dup --from packman --allow-vendor-change 2>&1 | tee -a "$LOG"
else
  echo -e "${INFO} ${YELLOW}Packman repository${RESET}  already exists, skipping addition.${RESET}"
fi


# Check if Packman-essentials repository already in system
#if ! sudo zypper repos | grep -q 'packman-essentials'; then
#  printf "\n%s - Adding ${SKY_BLUE}Packman repository Essentials${RESET} .... \n" "${NOTE}"

#  sudo zypper -n --quiet ar --refresh -p 90 "$packman_essentials" packman-essentials 2>&1 | tee -a "$LOG"
#  sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"
#  sudo zypper -n dup --from packman-essentials --allow-vendor-change 2>&1 | tee -a "$LOG"
#else
#  echo -e "${INFO} ${YELLOW}Packman-essential repository${RESET}  already exists, skipping addition.${RESET}"
#fi


printf "\n%.0s" {1..2}
