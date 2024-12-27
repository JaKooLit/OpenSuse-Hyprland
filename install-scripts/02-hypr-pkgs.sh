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
  gawk
  git
  go
  grim
  gvfs
  gvfs-backends
  ImageMagick
  inxi
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
  python312-requests
  python312-pip
  python311-pyquery
  python312-pyquery
  qt5ct
  qt6ct
  qt6-svg-devel
  rofi-wayland
  slurp
  swappy
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
  fastfetch
  mousepad
  mpv
  mpv-mpris
  nvtop
  qalculate-gtk
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

# List of packages to uninstall as it conflicts some packages
uninstall=(
  aylurs-gtk-shell
  dunst
  mako
  rofi
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

# uninstalling conflicting packages
printf "\n%s - Removing Mako, Dunst and rofi (if present) as it conflicts with swaync and rofi-wayland \n" "${NOTE}"
for PKG in "${uninstall[@]}"; do
  uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
done

# Installation of main components
printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${Extra[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# Installation of main components
printf "\n%s - Installing hyprland packages (no-recommends).... \n" "${NOTE}"

for PKG_N in "${package_no_recommends[@]}"; do
  install_package_no "$PKG_N" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# update home libraries
xdg-user-dirs-update 

clear
