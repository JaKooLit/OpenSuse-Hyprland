#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# adding additional repo

#All of Packman
#packman_repo="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"

# Only Essentials
packman_essentials="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/"

                  
## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_add-repo.log"

# Adding Packman repository and switching over to Packman
#printf "\n%s - Adding ${YELLOW}Packman repository (Globally)${RESET} .... \n" "${NOTE}"

#sudo zypper -n --quiet ar --refresh -p 90 "$packman_repo" packman 2>&1 | tee -a "$LOG"
#sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"
#sudo zypper -n dup --from packman --allow-vendor-change 2>&1 | tee -a "$LOG"

# Adding Packman essential repository
printf "\n%s - Adding ${YELLOW}Packman repository (Essentials)${RESET} .... \n" "${NOTE}"

sudo zypper -n --quiet ar --refresh -p 90 "$packman_essentials" packman-essentials 2>&1 | tee -a "$LOG"
sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"
sudo zypper -n dup --from packman-essentials --allow-vendor-change 2>&1 | tee -a "$LOG"


printf "\n%.0s" {1..2}
