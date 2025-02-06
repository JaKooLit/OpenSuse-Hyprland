#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Global Functions for Scripts #

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Log file
LOG="Install-Logs/install.log"

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"


# Show progress function
show_progress() {
    local pid=$1
    local package_name=$2
    local spin_chars=("●○○○○○○○○○" "○●○○○○○○○○" "○○●○○○○○○○" "○○○●○○○○○○" "○○○○●○○○○" \
                      "○○○○○●○○○○" "○○○○○○●○○○" "○○○○○○○●○○" "○○○○○○○○●○" "○○○○○○○○○●") 
    local i=0

    tput civis 
    printf "\r${INFO} Installing ${YELLOW}%s${RESET} ..." "$package_name"

    while ps -p $pid &> /dev/null; do
        printf "\r${INFO} Installing ${YELLOW}%s${RESET} %s" "$package_name" "${spin_chars[i]}"
        i=$(( (i + 1) % 10 ))  
        sleep 0.3  
    done

    printf "\r${INFO} Installing ${YELLOW}%s${RESET} ... Done!%-20s \n" "$package_name" ""
    tput cnorm  
}

# Function for installing packages (for devel_basis)
install_package_base() {
  # Check if package is already installed
  if zypper se -i "$1" &>/dev/null ; then
    echo -e "${INFO} ${MAGENTA}$1${RESET} is already installed. Skipping..."
  else
    (
      stdbuf -oL sudo zypper in -y -t pattern "$1" 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
  fi
}

# Function to install packages
install_package() {
  if zypper se -i "$1" &>/dev/null ; then
    echo -e "${INFO} ${MAGENTA}$1${RESET} is already installed. Skipping..."
  else
    (
      stdbuf -oL sudo zypper in -y "$1" 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
  fi
}

# Function for installing packages (NO Recommends)
install_package_no() {
  if zypper se -i "$1" &>/dev/null ; then
    echo -e "${INFO} ${MAGENTA}$1${RESET} is already installed. Skipping..."
  else
    (
      stdbuf -oL sudo zypper in -y --no-recommends "$1" 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
  fi
}

# Function for force installing a package
install_package_force() {
    echo -e "${INFO} Force installing ${MAGENTA}$1${RESET}"
    (
      stdbuf -oL sudo zypper in -y --force "$1" 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
}

# Function to install packages
install_package_opi() {
  if zypper se -i "$1" &>/dev/null ; then
    echo -e "${INFO} ${MAGENTA}$1${RESET} is already installed. Skipping..."
  else
    (
      stdbuf -oL sudo opi "$1" -n 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
  fi
}

# Function for installing packages (auto-agree)
install_package_agree() {
  if zypper se -i "$1" &>/dev/null ; then
    echo -e "${INFO} ${MAGENTA}$1${RESET} is already installed. Skipping..."
  else
    (
      stdbuf -oL sudo zypper in --auto-agree-with-licenses -y "$1" -n 2>&1
    ) >> "$LOG" 2>&1 &
    PID=$!
    show_progress $PID "$1" 

    # Double check if package is installed
    if zypper se -i "$1" &>/dev/null ; then
      echo -e "${OK} Package ${YELLOW}$1${RESET} has been successfully installed!"
    else
      echo -e "\n${ERROR} ${YELLOW}$1${RESET} failed to install. Please check the $LOG. You may need to install manually."
    fi
  fi
}

# Function for removing packages
uninstall_package() {
  local pkg="$1"

    # Checking if package is installed
  if zypper se -i "$pkg" &>/dev/null; then
    echo -e "${NOTE} Uninstalling $pkg ..."
    sudo zypper remove -y "$pkg" 2>&1 | tee -a "$LOG" | grep -v "error: target not found"

    if ! zypper se -i "$pkg" &>/dev/null; then
      echo -e "\e[1A\e[K${OK} $pkg was uninstalled."
    else
      echo -e "\e[1A\e[K${ERROR} $pkg failed to uninstall. Please check the log."
      return 1
    fi
  else
    echo -e "${INFO} Package $pkg not installed, skipping."
  fi
  return 0
}