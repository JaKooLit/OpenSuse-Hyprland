#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# wallust - pywal colors replacement #

depend=(
  rust
  cargo
  ImageMagick
)


## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

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

printf "\n%.0s" {1..2} 

# Install Wallust using Cargo
echo "Installing ${SKY_BLUE}Wallust via Cargo${RESET} ..." | tee -a "$LOG"
if cargo install wallust 2>&1 | tee -a "$LOG" ; then
    echo "${OK} ${MAGENTA}Wallust${RESET} installed successfully." | tee -a "$LOG"

    # Move the newly compiled binary to /usr/local/bin
    echo "Moving Wallust binary to /usr/local/bin..." | tee -a "$LOG"
    sudo mv "$HOME/.cargo/bin/wallust" /usr/local/bin 2>&1 | tee -a "$LOG"
else
    echo "Error: Wallust installation failed. Check the log file $LOG for details." | tee -a "$LOG"
    exit 1
fi

clear
