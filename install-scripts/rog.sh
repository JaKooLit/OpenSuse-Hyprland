#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Asus ROG asusctl and supergfxctl #

## dependencies are taken from the asusctl website https://gitlab.com/asus-linux/asusctl
asusctl=(
  rustup 
  make 
  cmake 
  systemd-devel 
  clang-devel 
  llvm-devel 
  gdk-pixbuf-devel 
  cairo-devel 
  pango-devel
  power-profiles-daemon 
  freetype2-devel 
  gtk3-devel 
  libexpat-devel 
  libayatana-indicator3-7
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_rog.log"

### Install software for Asus ROG laptops ###
printf " Installing asusctl dependencies...\n"
  for ASUS in "${asusctl[@]}"; do
  install_package_no  "$ASUS" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
  echo -e "\e[1A\e[K${ERROR} - $ASUS Package installation failed, Please check the installation logs"
  exit 1
  fi
  done

# additional steps required before installing asusctl
# adding current user to wheel group: See here re:adding user to wheel https://asus-linux.org/wiki/opensuse-guide/
printf "Checking if 'wheel' group exists...\n"
getent group wheel || sudo groupadd wheel 2>&1 | tee -a "$LOG" || true

printf "Adding user to wheel group...\n"
sudo gpasswd -a $(whoami) wheel 2>&1 | tee -a "$LOG" || true

# removing suse-prime and tlp as they are known interferring (see the asusctl linux website above)
sudo zypper rm -n -y suse-prime 2>&1 | tee -a "$LOG" || true

sudo zypper rm -n -y tlp 2>&1 | tee -a "$LOG" || true

# Function to handle the installation and log messages
install_and_log() {
  local project_name="$1"
  local git_url="$2"
  
  printf "${NOTE} Installing $project_name\n"

  if git clone "$git_url" "$project_name"; then
    cd "$project_name" || exit 1
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 2>&1 | tee -a "$LOG"
    source "$HOME/.cargo/env"
    make

    if sudo make install 2>&1 | tee -a "$LOG"; then
      printf "${OK} $project_name installed successfully.\n"
      if [ "$project_name" == "supergfxctl" ]; then
        # Enable supergfxctl
        sudo systemctl enable --now supergfxd 2>&1 | tee -a "$LOG"
      fi
    else
      echo -e "${ERROR} Installation failed for $project_name."
    fi

    # Return to the previous directory
    cd - || exit 1
  else
    echo -e "${ERROR} Cloning $project_name from $git_url failed."
  fi
}

# Download and build asusctl
install_and_log "asusctl" "https://gitlab.com/asus-linux/asusctl.git"

# Download and build supergfxctl
install_and_log "supergfxctl" "https://gitlab.com/asus-linux/supergfxctl.git"


clear

