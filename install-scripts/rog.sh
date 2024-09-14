#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Asus ROG asusctl and supergfxctl #

power=(
  power-profiles-daemon 
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_rog.log"

### Install software for Asus ROG laptops ###
printf " Installing additional for ASUS ROG...\n"
  for ASUS in "${power[@]}"; do
  install_package_no  "$ASUS" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
  echo -e "\e[1A\e[K${ERROR} - $ASUS Package installation failed, Please check the installation logs"
  exit 1
  fi
  done

# additional steps required before installing asusctl
# adding current user to wheel group: See here re:adding user to wheel https://asus-linux.org/wiki/opensuse-guide/
printf "Checking if 'wheel' group exists...\n"
getent group wheel || sudo groupadd wheel 2>&1 | tee -a "$LOG" || true

printf "Adding user to wheel group...\n"
sudo gpasswd -a $(whoami) wheel 2>&1 | tee -a "$LOG" || true

# removing suse-prime and tlp as they are known interferring (see the asusctl linux website above)
sudo zypper rm -n -y suse-prime 2>&1 | tee -a "$LOG" || true

sudo zypper rm -n -y tlp 2>&1 | tee -a "$LOG" || true

printf "\n%.0s" {1..2}

# Asus packages from OBS
opi_asus=(
  asusctl
  supergfxctl
)

# Installing packages from OBS
printf "${NOTE} Installing asus packages from OpenSuse Builder Service (OBS)...\n"
for opi_asus_pkg in "${opi_asus[@]}"; do
  install_package_opi "$opi_asus_pkg" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $opi_asus_pkg Package installation failed, Please check the installation logs"
    exit 1
  fi
done


printf " enabling rog services...\n"
sudo systemctl enable supergfxd 2>&1 | tee -a "$LOG"
sleep 1
sudo systemctl enable power-profiles-daemon 2>&1 | tee -a "$LOG"

clear

