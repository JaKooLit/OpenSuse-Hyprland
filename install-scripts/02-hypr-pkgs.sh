#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Hyprland-Dots Packages #
# edit your packages desired here. 
# WARNING! If you remove packages here, dotfiles may not work properly.
# and also, ensure that packages are present in OpenSuse Software repo or in OBS

# add packages wanted here
Extra=(
  
)

# packages neeeded
hypr_package=(
  curl
  git
  go
  grim
  gvfs
  gvfs-backends
  ImageMagick
  jq
  kitty
  kvantum-qt6
  kvantum-themes
  kvantum-manager
  libnotify-tools
  nano
  openssl
  pamixer
  pavucontrol
  playerctl  
  polkit-gnome
  python311-requests
  python311-pip
  python311-pywal
  qt5ct
  qt6ct
  qt6-svg-devel
  rofi-wayland
  slurp
  swappy
  swayidle
  SwayNotificationCenter
  swww
  wget
  wayland-protocols-devel
  wl-clipboard
  xdg-user-dirs
  xdg-utils
  xwayland
)

# the following packages can be deleted. however, dotfiles may not work properly
hypr_package_2=(
  brightnessctl
  btop
  cava
  mousepad
  mpv
  mpv-mpris
  nvtop
  vim
  yad
)

# The following will be installed with NO recommends
package_no_recommends=(
  waybar
  eog
  gnome-system-monitor
  NetworkManager-applet
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
  dunst
  mako
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"

# Installation of main components
printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${Extra[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

# Installation of main components
printf "\n%s - Installing hyprland packages (no-recommends).... \n" "${NOTE}"

for PKG_N in "${package_no_recommends[@]}"; do
  install_package_no "$PKG_N" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

# removing dunst and mako to avoid swaync conflict
printf "\n%s - Checking if mako or dunst are installed and removing for swaync to work properly \n" "${NOTE}"

for PKG in "${uninstall[@]}"; do
  uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG uninstallation had failed, please check the log"
    exit 1
  fi
done

# update home libraries
xdg-user-dirs-update 

clear
