#!/bin/bash
# https://github.com/JaKooLit

clear

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


# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting......."
    printf "\n%.0s" {1..2} 
    exit 1
fi

# install whiptails if detected not installed. Necessary for this version
if ! command -v whiptail >/dev/null; then
    echo "${NOTE} - whiptail is not installed. Installing..."
    sudo zypper in -y --no-recommends newt
    printf "\n%.0s" {1..1}
fi

# Check if --preset argument is provided
if [[ "$1" == "--preset" ]]; then
    
    # nvidia
    if [[ "$2" == "--nvidia" ]]; then
        sed -i 's/^nvidia=".*"/nvidia="Y"/' preset.sh
    fi
    
    source ./preset.sh
fi

printf "\n%.0s" {1..2}  
echo -e "\e[35m
	╦╔═┌─┐┌─┐╦    ╦ ╦┬ ┬┌─┐┬─┐┬  ┌─┐┌┐┌┌┬┐
	╠╩╗│ ││ │║    ╠═╣└┬┘├─┘├┬┘│  ├─┤│││ ││ 2025
	╩ ╩└─┘└─┘╩═╝  ╩ ╩ ┴ ┴  ┴└─┴─┘┴ ┴┘└┘─┴┘ OpenSuse TW
\e[0m"
printf "\n%.0s" {1..1}  

# Welcome message using whiptail (for displaying information)
whiptail --title "KooL OpenSuse-Hyprland (2025) Install Script" \
    --msgbox "Welcome to KooL OpenSuse-Hyprland (2025) Install Script!!!\n\n\
ATTENTION: Run a full system update and Reboot first !!! (Highly Recommended)\n\n\
NOTE: If you are installing on a VM, ensure to enable 3D acceleration else Hyprland may NOT start!" \
    15 80

# Ask if the user wants to proceed
if ! whiptail --title "Proceed with Installation?" \
    --yesno "Would you like to proceed?" 7 50; then
    echo -e "\n"
    echo "❌ ${INFO} You 🫵 chose ${YELLOW}NOT${RESET} to proceed. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    exit 1
fi

echo "👌 ${OK} 🇵🇭 ${MAGENTA}KooL..${RESET} ${SKY_BLUE}lets continue with the installation...${RESET}"

printf "\n%.0s" {1..1}

# install pciutils if detected not installed. Necessary for detecting GPU
if ! zypper se -i pciutils > /dev/null; then
    echo "pciutils is not installed. Installing..."
    sudo zypper in -y --no-recommends pciutils
    printf "\n%.0s" {1..1}
fi

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Path to the install-scripts directory
script_directory=install-scripts

# Function to execute a script if it exists and make it executable
execute_script() {
    local script="$1"
    local script_path="$script_directory/$script"
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        if [ -x "$script_path" ]; then
            env "$script_path"
        else
            echo "Failed to make script '$script' executable."
        fi
    else
        echo "Script '$script' not found in '$script_directory'."
    fi
}

#################
## Default values for the options (will be overwritten by preset file if available)
gtk_themes="OFF"
bluetooth="OFF"
thunar="OFF"
ags="OFF"
sddm="OFF"
sddm_theme="OFF"
xdph="OFF"
zsh="OFF"
pokemon="OFF"
rog="OFF"
dots="OFF"
input_group="OFF"
nvidia="OFF"

# Function to load preset file
load_preset() {
    if [ -f "$1" ]; then
        echo "✅ Loading preset: $1"
        source "$1"
    else
        echo "⚠️ Preset file not found: $1. Using default values."
    fi
}

# Check if --preset argument is passed
if [[ "$1" == "--preset" && -n "$2" ]]; then
    load_preset "$2"
fi

# List of services to check for active login managers
services=("gdm.service" "gdm3.service" "lightdm.service" "lxdm.service")

# Function to check if any login services are active
check_services_running() {
    active_services=()  # Array to store active services
    for svc in "${services[@]}"; do
        if systemctl is-active --quiet "$svc"; then
            active_services+=("$svc")  
        fi
    done

    if [ ${#active_services[@]} -gt 0 ]; then
        return 0  
    else
        return 1  
    fi
}

if check_services_running; then
    active_list=$(printf "%s\n" "${active_services[@]}")

    # Display the active login manager(s) in the whiptail message box
    whiptail --title "Active non-SDDM login manager(s) detected" \
        --msgbox "The following non-SDDM login manager(s) are active:\n\n$active_list\n\nWARN: DO NOT install or choose to install SDDM & SDDM theme" 12 60
fi

# Check if NVIDIA GPU is detected
nvidia_detected=false
if lspci | grep -i "nvidia" &> /dev/null; then
    nvidia_detected=true
    whiptail --title "NVIDIA GPU Detected" --msgbox "NVIDIA GPU detected in your system.\n\nNOTE: The script will install nvidia-dkms, nvidia-utils, and nvidia-settings if you choose to configure." 12 60
fi

# Initialize the options array for whiptail checklist
options_command=(
    whiptail --title "Select Options" --checklist "Choose options to install or configure\nNOTE: spacebar to select" 28 85 20
)

# Add NVIDIA options if detected
if [ "$nvidia_detected" == "true" ]; then
    options_command+=(
        "nvidia" "Do you want script to configure NVIDIA GPU?" "OFF"
    )
fi

# Check if user is already in the 'input' group
input_group_detected=false
if ! groups "$(whoami)" | grep -q '\binput\b'; then
    input_group_detected=true
    whiptail --title "Input Group" --msgbox "You are not currently in the input group.\n\nAdding you to the input group might be necessary for the Waybar keyboard-state functionality." 12 60
fi

# Add 'input_group' option if necessary
if [ "$input_group_detected" == "true" ]; then
    options_command+=(
        "input_group" "Add your USER to input group for some waybar functionality?" "OFF"
    )
fi

# Add the remaining static options
options_command+=(
    "gtk_themes" "Install GTK themes (required for Dark/Light function)" "OFF"
    "bluetooth" "Do you want script to configure Bluetooth?" "OFF"
    "thunar" "Do you want Thunar file manager to be installed?" "OFF"
    "ags" "Install AGS v1 for Desktop-Like Overview" "OFF"
    "sddm" "Install & configure SDDM login manager?" "OFF"
    "sddm_theme" "Download & Install Additional SDDM theme?" "OFF"
    "xdph" "Install XDG-DESKTOP-PORTAL-HYPRLAND (for screen share)?" "OFF"
    "zsh" "Install zsh shell with Oh-My-Zsh?" "OFF"
    "pokemon" "Add Pokemon color scripts to your terminal?" "OFF"
    "rog" "Are you installing on Asus ROG laptops?" "OFF"
    "dots" "Download and install pre-configured KooL Hyprland dotfiles?" "OFF"
)

while true; do
    # Execute the checklist and capture the selected options
    selected_options=$("${options_command[@]}" 3>&1 1>&2 2>&3)

    # Check if the user pressed Cancel (exit status 1)
    if [ $? -ne 0 ]; then
    	echo -e "\n"
        echo "❌ ${INFO} You 🫵 cancelled the selection. ${YELLOW}Goodbye!${RESET}"
        exit 0  # Exit the script if Cancel is pressed
    fi

    # If no option was selected, notify and restart the selection
    if [ -z "$selected_options" ]; then
        whiptail --title "Warning" --msgbox "⚠️ No options were selected. Please select at least one option." 10 60
        continue  # Return to selection if no options selected
    fi

    # Convert selected options into an array (preserving spaces in values)
    IFS=' ' read -r -a options <<< "$selected_options"

    # Prepare Confirmation Message
    confirm_message="You have selected the following options:\n\n"
    for option in "${options[@]}"; do
        confirm_message+=" - $option\n"
    done
    confirm_message+="\nAre you happy with these choices?"

    # onfirmation prompt
    if ! whiptail --title "Confirm Your Choices" --yesno "$(printf "%s" "$confirm_message")" 25 80; then
    	echo -e "\n"
        echo "❌ ${SKY_BLUE}You 🫵 cancelled the confirmation${RESET}. ${YELLOW}Exiting...${RESET}"
        exit 0  
    fi

    echo "👌 ${OK} You confirmed your choices. Proceeding with ${SKY_BLUE}KooL 🇵🇭 Hyprland Installation...${RESET}"
    break
done

# Proceed with installation
echo "${OK} - Proceeding with selected options..."

echo "Adding Packman Repo..."
sleep 1
execute_script "00-add-repo.sh"

echo "Installing necessary dependencies..."
sleep 1
execute_script "01-dependencies.sh"

echo "Installing necessary fonts..."
sleep 1
execute_script "fonts.sh"

echo "Installing Hyprland..."
sleep 1
execute_script "hyprland.sh"

sleep 1
execute_script "hypr-ecosystem.sh"
#execute_script "cliphist.sh"

sleep 1
execute_script "force-install.sh"

sleep 1
execute_script "03-opi-pkgs.sh"

sleep 1
execute_script "wallust.sh"

# Clean up the selected options (remove quotes and trim spaces)
selected_options=$(echo "$selected_options" | tr -d '"' | tr -s ' ')

# Convert selected options into an array (splitting by spaces)
IFS=' ' read -r -a options <<< "$selected_options"

# Loop through selected options
for option in "${options[@]}"; do
    case "$option" in
        sddm)
            if check_services_running; then
                active_list=$(printf "%s\n" "${active_services[@]}")
                whiptail --title "Error" --msgbox "One of the following login services is running:\n$active_list\n\nPlease stop & disable it or DO not choose SDDM." 12 60
                exec "$0"  
            else
                echo "Installing and configuring SDDM..."
                execute_script "sddm.sh"
            fi
            ;;
        nvidia)
            echo "Configuring nvidia stuff"
            execute_script "nvidia.sh"
            ;;
        gtk_themes)
            echo "Installing GTK themes..."
            execute_script "gtk_themes.sh"
            ;;
        input_group)
            echo "Adding user into input group..."
            execute_script "InputGroup.sh"
            ;;
        ags)
            echo "Installing AGS..."
            execute_script "ags.sh"
            ;;
        xdph)
            echo "Installing XDG-DESKTOP-PORTAL-HYPRLAND..."
            execute_script "xdph.sh"
            ;;
        bluetooth)
            echo "Configuring Bluetooth..."
            execute_script "bluetooth.sh"
            ;;
        thunar)
            echo "Installing Thunar file manager..."
            execute_script "thunar.sh"
            execute_script "thunar_default.sh"
            ;;
        sddm_theme)
            echo "Downloading & Installing Additional SDDM theme..."
            execute_script "sddm_theme.sh"
            ;;
        zsh)
            echo "Installing zsh with Oh-My-Zsh..."
            execute_script "zsh.sh"
            ;;
        pokemon)
            echo "Adding Pokemon color scripts to terminal..."
            execute_script "zsh_pokemon.sh"
            ;;
        rog)
            echo "Installing ROG packages..."
            execute_script "rog.sh"
            ;;
        dots)
            echo "Installing pre-configured Hyprland dotfiles..."
            execute_script "dotfiles-main.sh"
            ;;
        *)
            echo "Unknown option: $option"
            ;;
    esac
done

# Perform cleanup
printf "\n${OK} Performing some clean up.\n"
files_to_delete=("JetBrainsMono.tar.xz" "VictorMonoAll.zip" "FantasqueSansMono.zip")
for file in "${files_to_delete[@]}"; do
    if [ -e "$file" ]; then
        echo "$file found. Deleting..."
        rm "$file"
        echo "$file deleted successfully."
    fi
done

clear

# copy fastfetch config if opensuse is not present
if [ ! -f "$HOME/.config/fastfetch/opensuse.png" ]; then
    cp -r assets/fastfetch "$HOME/.config/"
fi

printf "\n%.0s" {1..2}
# final check essential packages if it is installed
execute_script "04-Final-Check.sh"

printf "\n%.0s" {1..1}

# Check if either hyprland or hyprland-git is installed
if sudo zypper se -i hyprland &> /dev/null || sudo zypper se -i hyprland-git &> /dev/null; then
    printf "\n${OK} Hyprland is installed. However, some essential packages may not be installed. Please see above!"
    printf "\n${CAT} Ignore this message if it states ${YELLOW}All essential packages${RESET} are installed as per above\n"
    sleep 2
    printf "\n%.0s" {1..2}

    printf "${SKY_BLUE}Thank you${RESET} for using ${MAGENTA}KooL's Hyprland Dots${RESET}. ${YELLOW}Enjoy and Have a good day!${RESET}"
    printf "\n%.0s" {1..2}

    printf "\n${NOTE} You can start Hyprland by typing ${SKY_BLUE}Hyprland${RESET} (IF SDDM is not installed) (note the capital H!).\n"
    printf "\n${NOTE} However, it is ${YELLOW}highly recommended to reboot${RESET} your system.\n\n"

    read -rp "${CAT} Would you like to reboot now? (y/n): " HYP

    HYP=$(echo "$HYP" | tr '[:upper:]' '[:lower:]')

    if [[ "$HYP" == "y" || "$HYP" == "yes" ]]; then
        echo "${INFO} Rebooting now..."
        systemctl reboot 
    elif [[ "$HYP" == "n" || "$HYP" == "no" ]]; then
        echo "${OK} You choose NOT to reboot"
        printf "\n%.0s" {1..1}
        # Check if NVIDIA GPU is present
        if lspci | grep -i "nvidia" &> /dev/null; then
            echo "${INFO} HOWEVER ${YELLOW}NVIDIA GPU${RESET} detected. Reminder that you must REBOOT your SYSTEM..."
            printf "\n%.0s" {1..1}
        fi
    else
        echo "${WARN} Invalid response. Please answer with 'y' or 'n'. Exiting."
        exit 1
    fi
else
    # Print error message if neither package is installed
    printf "\n${WARN} Hyprland is NOT installed. Please check 00_CHECK-time_installed.log and other files in the Install-Logs/ directory..."
    printf "\n%.0s" {1..3}
    exit 1
fi

printf "\n%.0s" {1..2}

