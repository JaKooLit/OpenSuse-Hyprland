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
LOG="Install-Logs/install-$(date +'%d-%H%M%S')_hypr-eco.log"

printf "${NOTE} Installing ${SKY_BLUE}hyprlock and hypridle via opi${RESET} \n"
# hypr-ecosystem packages
 for ECO in "${hypr_eco[@]}"; do
  install_package_opi "$ECO" "$LOG"
done

printf "\n%.0s" {1..2}