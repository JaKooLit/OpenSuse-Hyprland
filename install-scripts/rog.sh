#!/bin/bash

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
  freetype-devel 
  gtk3-devel 
  libexpat-devel 
  libayatana-indicator3-7
)


############## WARNING DO NOT EDIT BEYOND THIS LINE if you dont know what you are doing! ######################################
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S)_rog.log"


# Function for installing packages (NO Recommends)
install_package_2() {
  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    sudo zypper in -y --no-recommends "$1" 2>&1 | tee -a "$LOG"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to install :( , please check the install.log. You may need to install manually! Sorry I have tried :("
      exit 1
    fi
  fi
}

### Install software for Asus ROG laptops ###

printf " Installing asusctl dependencies...\n"
  for ASUS in "${asusctl[@]}"; do
  install_package_2  "$ASUS" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
  echo -e "\e[1A\e[K${ERROR} - $ASUS install had failed, please check the install.log"
  exit 1
  fi
  done

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

