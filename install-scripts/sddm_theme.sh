#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# SDDM themes #

source_theme="https://codeberg.org/JaKooLit/sddm-sequoia"
theme_name="sequoia_2"

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_sddm_theme.log"
    
# SDDM-themes
printf "${INFO} Installing ${SKY_BLUE}Additional SDDM Theme${RESET}\n"

# Check if /usr/share/sddm/themes/$theme_name exists and remove if it does
if [ -d "/usr/share/sddm/themes/$theme_name" ]; then
  sudo rm -rf "/usr/share/sddm/themes/$theme_name"
  echo -e "\e[1A\e[K${OK} - Removed existing $theme_name directory." 2>&1 | tee -a "$LOG"
fi

# Check if $theme_name directory exists in the current directory and remove if it does
if [ -d "$theme_name" ]; then
  rm -rf "$theme_name"
  echo -e "\e[1A\e[K${OK} - Removed existing $theme_name directory from the current location." 2>&1 | tee -a "$LOG"
fi

# Clone the repository
if git clone --depth 1 "$source_theme" "$theme_name"; then
  if [ ! -d "$theme_name" ]; then
    echo "${ERROR} Failed to clone the repository." | tee -a "$LOG"
  fi

  # Create themes directory if it doesn't exist
  if [ ! -d "/usr/share/sddm/themes" ]; then
    sudo mkdir -p /usr/share/sddm/themes
    echo "${OK} - Directory '/usr/share/sddm/themes' created." | tee -a "$LOG"
  fi

  # Move cloned theme to the themes directory
  sudo mv "$theme_name" "/usr/share/sddm/themes/$theme_name" 2>&1 | tee -a "$LOG"

  # setting up SDDM theme
  sddm_conf_dir="/etc/sddm.conf.d"
  BACKUP_SUFFIX=".bak"
  
  echo -e "${NOTE} Setting up the login screen." | tee -a "$LOG"

  if [ -d "$sddm_conf_dir" ]; then
    # If the directory exists, backup present files
    echo "Backing up files in $sddm_conf_dir" | tee -a "$LOG"
    for file in "$sddm_conf_dir"/*; do
      if [ -f "$file" ]; then
        # not change the backed up files
        if [[ "$file" == *$BACKUP_SUFFIX ]]; then
          echo "Skipping backup file: $file" | tee -a "$LOG"
          continue
        fi

        # Backup each original file
        sudo cp "$file" "$file$BACKUP_SUFFIX" 2>&1 | tee -a "$LOG"
        echo "Backup created for $file" | tee -a "$LOG"
        
        # editing present files in "/etc/sddm.conf.d"
        if grep -q '^[[:space:]]*Current=' "$file"; then
          sudo sed -i 's/^[[:space:]]*Current=/#&/' "$file" 2>&1 | tee -a "$LOG"  
          sudo sed -i "s/^[[:space:]]*#Current=.*/Current=$theme_name/" "$file" 2>&1 | tee -a "$LOG" 
          echo "Updated theme in $file" | tee -a "$LOG"
        fi
      fi
    done
  else
    # If the directory doesn't exist, create it and set up the new theme
    echo "$CAT - $sddm_conf_dir not found, creating..." | tee -a "$LOG"
    sudo mkdir -p "$sddm_conf_dir" 2>&1 | tee -a "$LOG"

    echo -e "[Theme]\nCurrent=$theme_name" | sudo tee "$sddm_conf_dir/theme.conf.user" 2>&1 | tee -a "$LOG"
    echo "Created and configured $sddm_conf_dir/theme.conf.user with theme $theme_name" | tee -a "$LOG"
  fi

  # Replace current background from assets
  sudo cp -r assets/sddm.png "/usr/share/sddm/themes/$theme_name/backgrounds/default" 2>&1 | tee -a "$LOG"
  sudo sed -i 's|^wallpaper=".*"|wallpaper="backgrounds/default"|' "/usr/share/sddm/themes/$theme_name/theme.conf" 2>&1 | tee -a "$LOG"

  printf "\n%.0s" {1..1}
  printf "${NOTE} copying ${YELLOW}JetBrains Mono Nerd Font${RESET} to ${YELLOW}/usr/local/share/fonts${RESET} .......\n"
  printf "${NOTE} necessary for the new SDDM theme to work properly........\n"

  sudo mkdir -p /usr/local/share/fonts/JetBrainsMonoNerd && \
  sudo cp -r "$HOME/.local/share/fonts/JetBrainsMonoNerd" /usr/local/share/fonts/JetBrainsMonoNerd

  if [ $? -eq 0 ]; then
    echo "Fonts copied successfully."
  else
    echo "Failed to copy fonts."
  fi

  # Update font cache and log the output
  fc-cache -v -f 2>&1 | tee -a "$LOG"

  printf "\n%.0s" {1..1}
  
  echo "${OK} - ${MAGENTA}Additional SDDM Theme${RESET} successfully installed." | tee -a "$LOG"

else

  echo "${ERROR} - Failed to clone the sddm theme repository. Please check your internet connection." | tee -a "$LOG" >&2
fi


printf "\n%.0s" {1..2}