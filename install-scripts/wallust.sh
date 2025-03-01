#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# wallust - pywal colors replacement #

depend=(
  rust
  cargo
  ImageMagick
)

wallust=(
  wallust
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_wallust.log"
MLOG="install-$(date +%d-%H%M%S)_wallust2.log"

echo "Installing ${SKY_BLUE}rust packages to install wallust${RESET} ..." | tee -a "$LOG"
# Installing depencies
for PKG1 in "${depend[@]}"; do
  install_package "$PKG1" "$LOG"
done

# Remove any existing Wallust binary
if [[ -f "/usr/local/bin/wallust" ]]; then
    echo "Removing existing Wallust binary..." 2>&1 | tee -a "$LOG"
    sudo rm "/usr/local/bin/wallust" 
fi

printf "\n%.0s" {1..1} 

# Install Wallust using Cargo
for WALL in "${wallust[@]}"; do
    cargo_install "$WALL" "$LOG"
    if [ $? -eq 0 ]; then  
        echo "${OK} ${MAGENTA}Wallust${RESET} installed successfully." | tee -a "$LOG"
    else
        echo "${ERROR} Installation of ${MAGENTA}$WALL${RESET} failed. Check the log file $LOG for details." | tee -a "$LOG"
        exit 1
    fi
done
printf "\n%.0s" {1..1} 
# Move the newly compiled binary to /usr/local/bin
echo "Moving Wallust binary to /usr/local/bin..." | tee -a "$LOG"
if sudo mv "$HOME/.cargo/bin/wallust" /usr/local/bin 2>&1 | tee -a "$LOG"; then
    echo "${OK} Wallust binary moved successfully to /usr/local/bin." | tee -a "$LOG"
else
    echo "${ERROR} Failed to move Wallust binary. Check the log file $LOG for details." | tee -a "$LOG"
    exit 1
fi


printf "\n%.0s" {1..2}
