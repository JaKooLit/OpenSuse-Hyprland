#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Final checking if packages are installed
# NOTE: These package checks are only the essentials

packages=(
  aylurs-gtk-shell
  rofi-wayland
  ImageMagick
  SwayNotificationCenter
  swww
  waybar
  wl-clipboard
  wlogout
  kitty
  hypridle
  hyprlock
  hyprland
  pyprland 
)

# Local packages that should be in /usr/local/bin/
local_pkgs_installed=(
  cliphist
  wallust 
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/00_CHECK-$(date +%d-%H%M%S)_installed.log"

printf "\n%s - Final Check if essential packages were installed \n" "${NOTE}"
# Initialize an empty array to hold missing packages
missing=()
local_missing=()

# Function to check if a package is installed using zypper
is_installed_zypper() {
    zypper se --installed-only "$1" > /dev/null 2>&1
}

# Loop through each package
for pkg in "${packages[@]}"; do
    # Check if the package is installed via zypper
    if ! is_installed_zypper "$pkg"; then
        missing+=("$pkg")
    fi
done

# Check for local packages
for pkg in "${local_pkgs_installed[@]}"; do
    if ! [ -f "/usr/local/bin/$pkg" ]; then
        local_missing+=("$pkg")
    fi
done

# Log missing packages
if [ ${#missing[@]} -eq 0 ] && [ ${#local_missing[@]} -eq 0 ]; then
    echo "${OK} All essential packages are installed." | tee -a "$LOG"
else
    if [ ${#missing[@]} -ne 0 ]; then
        echo "${WARN} The following packages are missing from zypper and will be logged:"
        for pkg in "${missing[@]}"; do
            echo "$pkg"
            echo "$pkg" >> "$LOG" # Log the missing package to the file
        done
    fi

    if [ ${#local_missing[@]} -ne 0 ]; then
        echo "${WARN} The following local packages are missing from /usr/local/bin/ and will be logged:"
        for pkg in "${local_missing[@]}"; do
            echo "$pkg is not installed since you can't find it in /usr/local/bin/"
            echo "$pkg" >> "$LOG" # Log the missing local package to the file
        done
    fi

    # Add a timestamp when the missing packages were logged
    echo "${NOTE} Missing packages logged at $(date)" >> "$LOG"
fi
