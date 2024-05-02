#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# hypr-ecosystem packages via OPI #

hypr_eco=(
  hyprlock
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +'%d-%H%M%S')_hypr-eco.log"

printf "${NOTE} Installing hypridle & hyprlock using opi\n"
# hypr-ecosystem packages
 for ECO in "${hypr_eco[@]}"; do
  install_package_opi "$ECO" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $ECO Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# Hyprland Plugins
# pyprland https://github.com/hyprland-community/pyprland installing using python
pip install pyprland 2>&1 | tee -a "$LOG" || True

clear