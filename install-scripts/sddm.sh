#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# SDDM with optional SDDM theme #

sddm=(
  sddm-qt6
  qt6-qt5compat-imports
  qt6-declarative
  qt6-svg
  xorg-x11-server
  xf86-input-evdev
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
for PKG1 in "${sddm[@]}" ; do
  install_package_no "$PKG1" "$LOG"
done

# Check if other login managers are installed and disable their service before enabling sddm
for login_manager in lightdm gdm lxdm lxdm-gtk3; do
  if sudo zypper se -i "$login_manager" > /dev/null; then
    echo "disabling $login_manager..."
    sudo systemctl disable "$login_manager.service" 2>&1 | tee -a "$LOG"
  fi
done


printf " Activating sddm service........\n"
sudo systemctl set-default graphical.target 2>&1 | tee -a "$LOG"
sudo update-alternatives --set default-displaymanager /usr/lib/X11/displaymanagers/sddm 2>&1 | tee -a "$LOG"
sudo systemctl enable sddm.service 2>&1 | tee -a "$LOG"

# Set up SDDM
echo -e "${NOTE} Setting up the login screen."
sddm_conf_dir=/etc/sddm.conf.d
[ ! -d "$sddm_conf_dir" ] && { printf "$CAT - $sddm_conf_dir not found, creating...\n"; sudo mkdir -p "$sddm_conf_dir" 2>&1 | tee -a "$LOG"; }

wayland_sessions_dir=/usr/share/wayland-sessions
[ ! -d "$wayland_sessions_dir" ] && { printf "$CAT - $wayland_sessions_dir not found, creating...\n"; sudo mkdir -p "$wayland_sessions_dir" 2>&1 | tee -a "$LOG"; }
sudo cp assets/hyprland.desktop "$wayland_sessions_dir/" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}
    
# SDDM-themes
valid_input=false
while [ "$valid_input" != true ]; do
    if [[ -z $install_sddm_theme ]]; then
      read -n 1 -r -p "${CAT} OPTIONAL - Would you like to install ${YELLOW}additional SDDM themes?${RESET} (y/n)" install_sddm_theme
    fi
  if [[ $install_sddm_theme =~ ^[Yy]$ ]]; then
    printf "\n%s - Installing ${SKY_BLUE}Additional SDDM Theme${RESET}\n" "${NOTE}"

    # Check if /usr/share/sddm/themes/sequoia_2 exists and remove if it does
    if [ -d "/usr/share/sddm/themes/sequoia_2" ]; then
      sudo rm -rf "/usr/share/sddm/themes/sequoia_2"
      echo -e "\e[1A\e[K${OK} - Removed existing 'sequoia_2' directory." 2>&1 | tee -a "$LOG"
    fi

    # Check if sequoia_2 directory exists in the current directory and remove if it does
    if [ -d "sequoia_2" ]; then
      rm -rf "sequoia_2"
      echo -e "\e[1A\e[K${OK} - Removed existing 'sequoia_2' directory from the current location." 2>&1 | tee -a "$LOG"
    fi

    if git clone --depth 1 https://codeberg.org/JaKooLit/sddm-sequoia sequoia_2; then
      while [ ! -d "sequoia_2" ]; do
        sleep 1
      done

      if [ ! -d "/usr/share/sddm/themes" ]; then
        sudo mkdir -p /usr/share/sddm/themes
        echo -e "\e[1A\e[K${OK} - Directory '/usr/share/sddm/themes' created." 2>&1 | tee -a "$LOG"
      fi

      sudo mv sequoia_2 /usr/share/sddm/themes/sequoia_2
      echo -e "[Theme]\nCurrent=sequoia_2" | sudo tee "$sddm_conf_dir/theme.conf.user" &>> "$LOG"

      # replace current background from assets
      sudo cp -r assets/sddm.png /usr/share/sddm/themes/sequoia_2/backgrounds/default
      sudo sed -i 's|^wallpaper=".*"|wallpaper="backgrounds/default"|' /usr/share/sddm/themes/sequoia_2/theme.conf 

  	  echo -e "\e[1A\e[K${OK} - ${MAGENTA}Additional SDDM Theme${RESET} successfully installed" | tee -a "$LOG" >&2
      
    else
      echo -e "\e[1A\e[K${ERROR} - Failed to clone the sddm theme repository. Please check your internet connection" | tee -a "$LOG" >&2
    fi
    valid_input=true
  elif [[ $install_sddm_theme =~ ^[Nn]$ ]]; then
    printf "\n%s - No SDDM themes will be installed.\n" "${NOTE}" 2>&1 | tee -a "$LOG"
    valid_input=true
  else
    printf "\n%s - Invalid input. Please enter 'y' for Yes or 'n' for No.\n" "${ERROR}" 2>&1 | tee -a "$LOG"
    install_sddm_theme=""
  fi
done

printf "\n%.0s" {1..2}
