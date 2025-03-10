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
  bc
  curl
  cliphist
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
  unzip # required later
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
  yad
)

# The following will be installed with NO recommends
package_no_recommends=(
  waybar
  loupe
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"

# conflicting packages removal
overall_failed=0
printf "\n%s - ${SKY_BLUE}Removing some packages${RESET} as it conflicts with KooL's Hyprland Dots \n" "${NOTE}"
for PKG in "${uninstall[@]}"; do
  uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    overall_failed=1
  fi
done

if [ $overall_failed -ne 0 ]; then
  echo -e "${ERROR} Some packages failed to uninstall. Please check the log."
fi

printf "\n%.0s" {1..1}

# Installation of main components
printf "\n%s - Installing ${SKY_BLUE}KooL's hyprland necessary packages${RESET} .... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${Extra[@]}"; do
  install_package "$PKG1" "$LOG"
done

for PKG_N in "${package_no_recommends[@]}"; do
  install_package_no "$PKG_N" "$LOG"
done

# update home libraries
xdg-user-dirs-update 

printf "\n%.0s" {1..2}