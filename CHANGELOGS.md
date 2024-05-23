## Changelogs

## 23 May 2024
- added qalculate-gtk to work with rofi-calc. Default keybinds (SUPER ALT C)
- added power-profiles-daemon for ROG laptops. Note, I cant add to all since it conflicts with TLP, CPU-Auto-frequency etc.
- added fastfetch

## 19 May 2024
- Disabled the auto-login in .zprofile as it causes auto-login to Hyprland if any wayland was chosen. Can enabled if only using hyprland

## 10 May 2024
- added wallust-git and remove python-pywal for migration to wallust on Hyprland-Dots v2.2.11

## 07 May 2024
- added ags.sh for upcoming ags overview for next Hyprland-Dots release. Will be installed form source

## 03 May 2024
- added python3-pyquery for new weather-waybar python based on Hyprland-Dots

## 02 May 2024
- Added pyprland (hyprland plugin)

## 26 Apr 2024
- Updated sddm.sh for Qt6 variant (reverted back) - aint working

## 25 Apr 2024
- updated fonts.sh install script to install Jetbrains Mono Nerd Font

## 23 Apr 2024
- Dropping swayidle and swaylock in favor of hypridle and hyprlock

## 20 Apr 2024
- Change default Oh-my-zsh theme to xiong-chiamiov-plus

## 11 Jan 2024
- dropped wlsunset

## 30 December 2023
- Install scripts cleaned up and better collection of install-logs
- Pokemon Colorscripts is not optional

## 29 December 2023
- Remove dunst in favor of swaync. NOTE: Part of the script is to also uninstall mako and dunst (if installed) as on my experience, dunst is sometimes taking over the notification even if it is not set to start

## 16 Dec 2023
- zsh theme switched to `agnoster` theme by default
- pywal tty color change disabled by default

## 13 Dec 2023
- Added a script / function to force install packages. Some users reported that it is not installed.

## 11 Dec 2023
- Changing over to zsh automatically if user opted
- If chose to install zsh and have no login manager, zsh auto login will auto start Hyprland
- added as optional, with zsh, pokemon colorscripts
- improved zsh install scripts, so even the existing zsh users of can still opt for zsh and oh-my-zsh installation :)

## 05 Dec 2023
- Finally Nvidia GPU is supported :)

## 03 Dec 2023
- Added kvantum for qt apps theming
- return of wlogout due to theming issues of rofi-power

### 02 Dec 2023
- SDDM install script is now ready :) (NOTE! I chose sddm-qt6 to install!)

### 27 Nov 2023
- ROG (asusctl and supergfxctl) are now ready. note! building from source as opi install gives me a failer

### 26 Nov 2023
- Public Release

### 25 Nov 2023
- drop wlogout since Hyprland-Dots v2.1.9 uses rofi-power



