## Changelogs

## 20 Feb 2025
- Added nwg-displays for the upcoming Kools dots v2.3.12
- 
## 18 Feb 2025
- Change default zsh theme to adnosterzak
- pokemon coloscript integrated with fastfetch when opted with pokemon to add some bling
- additional external oh-my-zsh theme

## 16 Feb 2025
- cliphist is now in official repo

## 06 Feb 2025
- added semi-unattended function.
- move all the initial questions at the beginning

## 04 Feb 2025
- Re-coded for better visibility
- Offered a new SDDM theme.
- script will automatically detect if you have nvidia but script still offer if you want to set up for user

## 30 Jan 2025
- AGS (aylur's GTK shell) v1 for desktop overview is now optional

## 12 Jan 2025
- switch to final version of aylurs-gtk-shell-v1

## 07 Jan 2025
- default theme for oh my zsh theme is now "funky" 
- added fastfetch compact-config for opensuse (cant find a good tumbleweed one)

## 27 Dec 2024
- install hyprland-qtutils from Suse OBS

## 26 Dec 2024
- Removal of Bibata Ice cursor on assets since its integrated in the GTK Themes and Icons extract from a separate repo
- integrated hyprcursor in Bibata Ice Cursor

## 16 Nov 2024
- adjusted ags v1.8.2 install script

## 15 Nov 2024
- revert Aylurs GTK Shell (AGS) to install older version

## 20 Sep 2024
- User will be ask if they want to set Thunar as default file manager if they decided to install it

## 19 Sep 2024
- Added fastfetch on tty. However, will be disabled if user decided to install pokemon colorscripts

## 18 Sep 2024
- dotfiles will now be downloaded from main or master branch instead of from the releases version.

## 14 Sep 2024
- Refactor install scripts (opi packages in one install-script)
- Discarded final error check in favor of checking for essential packages function to check if all essential packages are installed

## 08 Sep 2024
- Added final error checks on install-logs

## 28 Aug 2024
- Added final check if hyprland is installed and will give an error to user

## 26 Aug 2024
- added nvidia_drm.fbdev=1 for grub

## 13 Aug 2024
- updated to download from Hyprland-Dots releases as usual

## 09 Aug 2024
- updated dotfiles.sh to download from Hyprland-Dots main branch for Hyprland 0.42.0 update

## 07 Jul 2024
- added eza (ls replacement for tty). Note only on .zshrc

## 26 May 2024
- Added fzf for zsh (CTRL R to invoke FZF history)

## 25 May 2024
- switched to sddm-qt6 theme. Link of which is on readme

## 23 May 2024
- added qalculate-gtk to work with rofi-calc. Default keybinds (SUPER ALT C)
- added power-profiles-daemon for ROG laptops. Note, I cant add to all since it conflicts with TLP, CPU-Auto-frequency etc.
- added fastfetch

## 22 May 2024
- change the sddm theme destination to /etc/sddm.conf.d/10-theme.conf to theme.conf.user
- 
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



