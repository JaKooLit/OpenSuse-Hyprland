#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# hypr-ecosystem packages via OPI #

hypr_eco=(
  python311-aiofiles
  python-base
  hyprlock
  hypridle
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

printf "${NOTE} Installing ${SKY_BLUE}hyprlock using opi${RESET} \n"
# hypr-ecosystem packages
 for ECO in "${hypr_eco[@]}"; do
  install_package_opi "$ECO" "$LOG"
done

# Check if the file exists and delete it
pypr="/usr/local/bin/pypr"
if [ -f "$pypr" ]; then
    sudo rm "$pypr"
fi

# Hyprland Plugins
# pyprland https://github.com/hyprland-community/pyprland installing using python
printf "${NOTE} Installing ${SKY_BLUE}pyprland${RESET} \n"

curl https://raw.githubusercontent.com/hyprland-community/pyprland/main/scripts/get-pypr | sh  2>&1 | tee -a "$LOG"

sudo pip install pyprland --break-system-packages 2>&1 | tee -a "$LOG" 

printf "\n%.0s" {1..2}

