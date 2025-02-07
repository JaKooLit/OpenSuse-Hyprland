#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Thunar #

thunar=(
  thunar-volman 
  tumbler 
)

# no recommends
thunar2=(
  thunar
)

thunar_opi=(
  xarchiver
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
printf "\n%s - Installing ${YELLOW}Thunar${RESET} packages (no-recommends).... \n" "${NOTE}"
for PKG_N in "${thunar2[@]}"; do
  install_package_no "$PKG_N" "$LOG"
done

printf "${NOTE} Installing ${YELLOW}additional Thunar Packages${RESET} ...\n"  
  for THUNAR in "${thunar[@]}"; do
    install_package "$THUNAR" "$LOG"
  done

for topi_pkg in "${thunar_opi[@]}"; do
  install_package_opi "$topi_pkg" "$LOG"
done

printf "\n%.0s" {1..1}

 # Check for existing configs and copy if does not exist
for DIR1 in gtk-3.0 Thunar xfce4; do
  DIRPATH=~/.config/$DIR1
  if [ -d "$DIRPATH" ]; then
    echo -e "${NOTE} Config for ${MAGENTA}$DIR1${RESET} found, no need to copy." 2>&1 | tee -a "$LOG"
  else
    echo -e "${NOTE} Config for ${YELLOW}$DIR1${RESET} not found, copying from assets." 2>&1 | tee -a "$LOG"
    cp -r assets/$DIR1 ~/.config/ && echo "${OK} Copy $DIR1 completed!" || echo "${ERROR} Failed to copy $DIR1 config files." 2>&1 | tee -a "$LOG"
  fi
done

printf "\n%.0s" {1..2}
