#!/bin/bash

# https://github.com/JaKooLit

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

clear

echo " 

     ██╗ █████╗    ██╗  ██╗ ██████╗  ██████╗ ██╗     ██╗████████╗
     ██║██╔══██╗   ██║ ██╔╝██╔═══██╗██╔═══██╗██║     ██║╚══██╔══╝
     ██║███████║   █████╔╝ ██║   ██║██║   ██║██║     ██║   ██║   
██   ██║██╔══██║   ██╔═██╗ ██║   ██║██║   ██║██║     ██║   ██║   
╚█████╔╝██║  ██║██╗██║  ██╗╚██████╔╝╚██████╔╝███████╗██║   ██║   
 ╚════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝   ╚═╝   
                                                                 

"

# Welcome message
echo "$(tput setaf 6)Welcome to JaKooLit's OpenSuSe (Tumbleweed)-Hyprland Install Script!$(tput sgr0)"
echo
echo "$(tput setaf 166)ATTENTION: Run a full system update and Reboot first!! (Highly Recommended) $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: You will be required to answer some questions during the installation! $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: If you are installing on a VM, ensure to enable 3D acceleration else Hyprland wont start! $(tput sgr0)"
echo
echo "$(tput setaf 166)ATTENTION: For now, NO NVIDIA SUPPORT! $(tput sgr0)"
echo

read -p "$(tput setaf 6)Would you like to proceed? (y/n): $(tput sgr0)" proceed

if [ "$proceed" != "y" ]; then
    echo "Installation aborted."
    exit 1
fi

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Function to colorize prompts
colorize_prompt() {
    local color="$1"
    local message="$2"
    echo -n "${color}${message}$(tput sgr0)"
}

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

# Initialize variables to store user responses
bluetooth=""
dots=""
gtk_themes=""
rog=""
#sddm=""
swaylock=""
thunar=""
xdph=""
zsh=""

# Define the directory where your scripts are located
script_directory=install-scripts

# Function to ask a yes/no question and set the response in a variable
ask_yes_no() {
    while true; do
        read -p "$(colorize_prompt "$CAT"  "$1 (y/n): ")" choice
        case "$choice" in
            [Yy]* ) eval "$2='Y'"; return 0;;
            [Nn]* ) eval "$2='N'"; return 1;;
            * ) echo "Please answer with y or n.";;
        esac
    done
}

# Function to ask a custom question with specific options and set the response in a variable
ask_custom_option() {
    local prompt="$1"
    local valid_options="$2"
    local response_var="$3"

    while true; do
        read -p "$(colorize_prompt "$CAT"  "$prompt ($valid_options): ")" choice
        if [[ " $valid_options " == *" $choice "* ]]; then
            eval "$response_var='$choice'"
            return 0
        else
            echo "Please choose one of the provided options: $valid_options"
        fi
    done
}
# Function to execute a script if it exists and make it executable
execute_script() {
    local script="$1"
    local script_path="$script_directory/$script"
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        if [ -x "$script_path" ]; then
            "$script_path"
        else
            echo "Failed to make script '$script' executable."
        fi
    else
        echo "Script '$script' not found in '$script_directory'."
    fi
}

# Collect user responses to all questions
printf "\n"
ask_yes_no "-Install GTK themes (required for Dark/Light function)?" gtk_themes
printf "\n"
ask_yes_no "-Do you want to configure Bluetooth?" bluetooth
printf "\n"
ask_yes_no "-Do you want to install Thunar file manager?" thunar
printf "\n"
ask_yes_no "-Installing on Asus ROG Laptops?" rog
printf "\n"
#ask_yes_no "-Install and configure SDDM log-in Manager?" sddm
#printf "\n"
ask_yes_no "Install XDG-DESKTOP-PORTAL-HYPRLAND? (for proper Screen Share ie OBS)" xdph
printf "\n"
ask_yes_no "-Do you want to install zsh and oh-my-zsh?" zsh
printf "\n"
ask_yes_no "-Do you want to copy Hyprland dotfiles?" dots
printf "\n"

# Ensuring all in the scripts folder are made executable
chmod +x install-scripts/*

# Install hyprland packages
execute_script "00-dependencies.sh"
execute_script "01-packman.sh"
execute_script "00-hypr-pkgs.sh"
execute_script "fonts.sh"
execute_script "hyprland.sh"
execute_script "wlogout.sh"
execute_script "nwg-look.sh"
execute_script "swaylock-effects.sh"

if [ "$gtk_themes" == "Y" ]; then
    execute_script "gtk_themes.sh"
fi

if [ "$bluetooth" == "Y" ]; then
    execute_script "bluetooth.sh"
fi

if [ "$thunar" == "Y" ]; then
    execute_script "thunar.sh"
fi

if [ "$rog" == "Y" ]; then
    execute_script "rog.sh"
fi

#if [ "$sddm" == "Y" ]; then
#    execute_script "sddm.sh"
#fi

if [ "$xdph" == "Y" ]; then
    execute_script "xdph.sh"
fi

if [ "$swaylock" == "Y" ]; then
    execute_script "swaylock-effects.sh"
fi

# nwg look (placed here to esure dependencies ae installed)
execute_script "nwg-look.sh"

if [ "$zsh" == "Y" ]; then
    execute_script "zsh.sh"
fi

if [ "$dots" == "Y" ]; then
    execute_script "dotfiles.sh"
fi

clear

printf "\n${OK} Yey! Installation Completed.\n"
printf "\n"
printf "\n${NOTE} NOTICE TO NVIDIA OWNERS! IT's a MUST for your to reboot your system\n"
sleep 2
printf "\n${NOTE} You can start Hyprland by typing Hyprland (IF SDDM is not installed) (note the capital H!).\n"
printf "\n"
printf "\n${NOTE} It is highly recommended to reboot your system.\n\n"
read -n1 -rep "${CAT} Would you like to reboot now? (y,n)" HYP

if [[ $HYP =~ ^[Yy]$ ]]; then
    if [[ "$nvidia" == "Y" ]]; then
        echo "${NOTE} NVIDIA GPU detected. Rebooting the system..."
        systemctl reboot
    else
        systemctl reboot
    
    fi    
fi

