#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Thunar #

thunar=(
  thunar-volman 
  tumbler 
  thunar-plugin-archive
)

# no recommends
thunar2=(
  thunar
  file-roller
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_thunar.log"

# Thunar
printf "\n%s - Installing thunar packages (no-recommends).... \n" "${NOTE}"
for PKG_N in "${thunar2[@]}"; do
  install_package_no "$PKG_N" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

printf "${NOTE} Installing additional Thunar Packages...\n"  
  for THUNAR in "${thunar[@]}"; do
    install_package "$THUNAR" 2>&1 | tee -a "$LOG"
    [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $THUNAR install had failed, please check the install.log"; exit 1; }
  done

 # Check for existing configs and copy if does not exist
for DIR1 in Thunar xfce4; do
  DIRPATH=~/.config/$DIR1
  if [ -d "$DIRPATH" ]; then
    echo -e "${NOTE} Config for $DIR1 found, no need to copy." 2>&1 | tee -a "$LOG"
  else
    echo -e "${NOTE} Config for $DIR1 not found, copying from assets." 2>&1 | tee -a "$LOG"
    cp -r assets/$DIR1 ~/.config/ && echo "Copy $DIR1 completed!" || echo "Error: Failed to copy $DIR1 config files." 2>&1 | tee -a "$LOG"
  fi
done

clear
