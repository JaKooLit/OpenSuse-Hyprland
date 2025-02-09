#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# SDDM with optional SDDM theme #

sddm_no=(
  sddm-qt6
)

sddm=(
  qt6-qt5compat-imports
  qt6-declarative
  qt6-svg
  xorg-x11-server
  xf86-input-evdev
)

# login managers to attempt to disable
login=(
  lightdm 
  gdm3 
  gdm 
  lxdm 
  lxdm-gtk3
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_sddm.log"


# Install SDDM 
printf "\n%s - Installing ${SKY_BLUE}SDDM and dependencies${RESET} .... \n" "${NOTE}"
for PKG1 in "${sddm_no[@]}" ; do
  install_package_no "$PKG1" "$LOG"
done

for PKG1 in "${sddm[@]}" ; do
  install_package_no "$PKG1" "$LOG"
done

# Check if other login managers are installed and disable their service before enabling sddm
for login_manager in "${login[@]}"; do
  if sudo zypper se -i "$login_manager" > /dev/null; then
    echo "disabling $login_manager..."
    sudo systemctl disable "$login_manager.service" >> "$LOG" 2>&1
    echo "$login_manager disabled."
  fi
done

# Double check with systemctl
for manager in "${login[@]}"; do
  if systemctl is-active --quiet "$manager" > /dev/null 2>&1; then
    echo "$manager is active, disabling it..." >> "$LOG" 2>&1
    sudo systemctl disable "$manager" --now >> "$LOG" 2>&1
  fi
done

printf "\n%.0s" {1..1}
printf "${INFO} Activating sddm service........\n"
sudo systemctl set-default graphical.target 2>&1 | tee -a "$LOG"
sudo update-alternatives --set default-displaymanager /usr/lib/X11/displaymanagers/sddm 2>&1 | tee -a "$LOG"
sudo systemctl enable sddm.service 2>&1 | tee -a "$LOG"

wayland_sessions_dir=/usr/share/wayland-sessions
[ ! -d "$wayland_sessions_dir" ] && { printf "$CAT - $wayland_sessions_dir not found, creating...\n"; sudo mkdir -p "$wayland_sessions_dir" 2>&1 | tee -a "$LOG"; }
sudo cp assets/hyprland.desktop "$wayland_sessions_dir/" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}
