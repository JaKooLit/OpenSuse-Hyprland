#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Nvidia - Check Readme for more details for the drivers #

nvidia_pkg=(
  openSUSE-repos-NVIDIA
  dkms
  libvdpau1
  libva-vdpau-driver
  libva-utils
  libglvnd
  libglvnd-devel
  Mesa-libva
  xf86-video-nv
)

nvidia_drivers=(
  nvidia-driver-G06
  nvidia-driver-G06-kmp-default
  nvidia-video-G06
  nvidia-gl-G06
  nvidia-utils-G06
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_nvidia.log"

# adding NVIDIA repo
sudo zypper -n --quiet ar --refresh -p 90 https://download.nvidia.com/opensuse/tumbleweed NVIDIA
sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$LOG"

# Install additional Nvidia packages
printf "${YELLOW} Installing Nvidia packages...\n"
  for NVIDIA in "${nvidia_pkg[@]}" "${nvidia_drivers[@]}"; do
    install_package_agree "$NVIDIA" 2>&1 | tee -a "$LOG"
  done

printf "${YELLOW} adding nvidia-stuff to /etc/default/grub..."

# Additional options to add to GRUB_CMDLINE_LINUX
additional_options="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1"

# Check if additional options are already present in GRUB_CMDLINE_LINUX
if grep -q "GRUB_CMDLINE_LINUX.*$additional_options" /etc/default/grub; then
  echo "GRUB_CMDLINE_LINUX already contains the additional options" 2>&1 | tee -a "$LOG"
  else
  # Append the additional options to GRUB_CMDLINE_LINUX
  sudo sed -i "s/GRUB_CMDLINE_LINUX=\"/GRUB_CMDLINE_LINUX=\"$additional_options /" /etc/default/grub
  echo "Added the additional options to GRUB_CMDLINE_LINUX" 2>&1 | tee -a "$LOG"
fi

# Update GRUB configuration
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Nvidia DRM modeset and additional options have been added to /etc/default/grub. Please reboot for changes to take effect." 2>&1 | tee -a "$LOG"

clear
