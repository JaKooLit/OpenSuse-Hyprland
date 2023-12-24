<div align="center">

# 💌 ** JaKooLit's Opensuse Tumbleweed - Hyprland Install Script ** 💌

![GitHub Repo stars](https://img.shields.io/github/stars/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7) ![GitHub last commit](https://img.shields.io/github/last-commit/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=b4befe) ![GitHub repo size](https://img.shields.io/github/repo-size/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7)

<br/>
</div>

### Screenshots 
<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-ScreenShots/OpenSuse/OpenSUSE1.png" /> <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-ScreenShots/OpenSuse/OpenSUSE2.png" />   

</p>

<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/default-waybar.png" /> <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/rofi.png" />   
   <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/wlogout-dark.png" /> <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/showcase2.png"" /> 
   <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/waybar-layout.png" /> <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-Dots-Showcase/waybar-style.png"" /> 
</p>

<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-ScreenShots/OpenSuse/nvidia-opensuse.png" /> <img align="center" width="49%" src="https://raw.githubusercontent.com/JaKooLit/screenshots/main/Hyprland-ScreenShots/OpenSuse/nvidia-opensuse2.png" />  

</p>

### 📷 More Screenshots (from other distros since it it using same Hyprland Dots) [`Link`](https://github.com/JaKooLit/screenshots/tree/main/Hyprland-V2-Screenshots/General/)

### 📹 Video presentation [`Youtube Link`](https://youtu.be/xmSW9W-MbME?si=h9p8b8Z_GmsgafRS)

## 🪧🪧🪧 ANNOUNCEMENT 🪧🪧🪧
- This Repo does not contain Hyprland Dots or configs! Dotfiles can be checked here [`Hyprland-Dots`](https://github.com/JaKooLit/Hyprland-Dots) . During installation, if you opt to copy installation, it will be downloaded from that centralized repo.
- Hyprland-Dots use are constantly evolving / improving. you can check CHANGELOGS here [`Hyprland-Dots-Changelogs`](https://github.com/JaKooLit/Hyprland-Dots/wiki/7.-CHANGELOGS)
- Since the Hyprland-Dots are evolving, some of the screenshots maybe old

## Activating Packman Repo
- by default, the packman mirror chosen is "https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"
- if you require to change the mirror, edit install-scripts/00-packman.sh and add mirrors of your choice. you can find mirrors [HERE](http://packman.links2linux.org/mirrors)

> [❗!IMPORTANT]
> install a backup tool like `snapper` or `timeshift`. and Backup your system before installing hyprland using this script. This script does NOT include uninstallation of packages

### 🆕  Prerequisites
- This install script is intended for atleast Server type installed.
- In theory, This should work on a any Tumbleweed with DE (Plasma, Gnome, XFCE). Although I am not sure about xfce default login manager if able to detect Hyprland.
- If you have nvidia, and wanted to use proprietary drivers, uninstall nouveau first (if installed). This script will be installing proprietary nvidia drivers and will not deal with removal of nouveau.

### ✨  Some notes on installation
- Some apps are being installed using OPI. These packages are wlogout, swaylock-effects and nwg-look
- for SDDM, by script sddm-qt6 will be installed. If you have already sddm, I HIGHLY SUGGEST NOT to install sddm through this script since I dont know the impact to your current sddm. Opensuse ship 2 version, sddm and sddm-qt6. The latter is more up to date... (I think)
- Another for SDDM, if you are installing from a server type of opensuse install, I highly suggest to install the sddm theme since you'll get a vanilla look sddm theme. 

### ✨ Costumize the packages
- inside the install-scripts folder, you can edit 02-hypr-pkgs.sh, etc. Care though as the Hyprland Dots might not work properly
- default GTK theme if agreed to be installed is Tokyo night GTK themes (dark and light) + Tokyo night SE icons

### 💫 SDDM and GTK Themes offered
- If you opted to install SDDM theme, here's the [`LINK`](https://github.com/JaKooLit/simple-sddm)
- If you opted to install GTK Themes, Icons and Cursor offered are Tokyo Nights. [`LINK`](https://github.com/JaKooLit/GTK-themes-icons) & Bibata Cursor Modern Ice 

### ⚠️ WARNING! If you have GDM already as log-in manager, DO NOT install SDDM
- You will likely to encounter issues

### 🔔 NOTICE TO NVIDIA OWNERS ### 
- Please take note that the nvidia driver will be install is G06 driver, which is for GeForce 700 series (Maxwell, Pascal...) and up see here [`NVIDIA-Opensuse-Link`](https://en.opensuse.org/SDB:NVIDIA_drivers)
- You can edit the install-scripts/nvidia.sh if you require for older cards. However, do take note that it may not work as older nvidia drivers dont support wayland well.
> [!IMPORTANT]
> If you want to use nouveau driver, choose N when asked if you have nvidia gpu. This is because the nvidia installer part, it will blacklist nouveau. Hyprland will still be installed but it will skip blacklisting nouveau.

### 🔔 NOTICE TO ASUS ROG Laptop owners ### 
- There is an guide by Asusctl dev [`Asusctl`](https://asus-linux.org/wiki/opensuse-guide/)
- However. during my test, the ROG gui is not behaving well, and I cant click any button. So The asusctl and supergfxctl that I have set here are build from source through their gitlab

### ✨ to run
> clone this repo by using git. Change directory, make executable and run the script
```bash
git clone https://github.com/JaKooLit/OpenSuse-Hyprland.git
cd OpenSuse-Hyprland
chmod +x install.sh
./install.sh
```

<p align="center">
    <img align="center" width="100%" src="https://raw.githubusercontent.com/JaKooLit/OpenSuse-Hyprland/main/OpenSuse-Installer.png" />

### ✨ for ZSH and OH-MY-ZSH installation
> installer should auto change your default shell to zsh. However, if it does not, do this
```bash
chsh -s $(which zsh)
zsh
source ~/.zshrc
```
- reboot or logout
- by default agnoster theme is installed. You can find more themes from this [`OH-MY-ZSH-THEMES`](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
- to change the theme, edit ~/.zshrc ZSH_THEME="desired theme"

### ✨ TO DO once installation done and dotfiles copied
- ~~if you opted to install gtk themes, to apply the theme and icon, press the dark/light button (beside the padlock). To apply Bibata modern ice cursor, launch nwg-look (GTK Settings) through rofi.~~ Hyprland-Dots v2.1.18, initial boot file will attempt to apply GTK themes,cursor, and icons. You can tweak more using nwg-look (GTK-Settings) utility

- SUPER H for HINT or click on the waybar HINT! Button 
- Head over to [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/4.-FAQ) and [TIPS](https://github.com/JaKooLit/Hyprland-Dots/wiki/5.-TIPS)

### 🏴‍☠️🏴‍☠️🏴‍☠️ Got a questions regarding the Hyprland Dots?
- Head over to wiki Link [`WIKI`](https://github.com/JaKooLit/Hyprland-Dots/wiki)

### ❗ some known issues on this Installer
- some users reported that they have to install some packages. It is in the install-scripts/force-install.sh
- At this time the packages force to install are the following `playerctl`

### 🛣️ TO DO:
- ~~[ ] Install zsh and oh-my-zsh without necessary steps above~~ DONE 
- ~~[ ] Make it fully functional (duh 🤣)~~ done
- ~~[ ] hyprland-nvidia - NOT SUPPORTED~~ NOW SUPPORTED 🥳
- ~~[ ] SDDM is not starting. However, if you opt to install zsh, I have already set for auto log-in to Hyprland so once you set up zsh like the instruction above. You just need to type username and password.~~ FIXED 🥳

### ❗ some known issues on Hyprland-Dots
- See FAQ section of Hyprland-Dots [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/4.-FAQ)

### 📒 Final Notes
- join my discord channel [`Discord`](https://discord.gg/V2SJ92vbEN)
- Feel free to copy, re-distribute, and use this script however you want. Would appreciate if you give me some loves by crediting my work :)

### 👍👍👍 Thanks and Credits!
- [`Hyprland`](https://hyprland.org/) Of course to Hyprland and @vaxerski for this awesome Dynamic Tiling Manager.

## 💖 Support
- a Star on my Github repos would be nice 🌟

- Subscribe to my Youtube Channel [YouTube](https://www.youtube.com/@Ja.KooLit) 

- You can also buy me Coffee Through ko-fi.com 🤩

<a href='https://ko-fi.com/jakoolit' target='_blank'><img height='35' style='border:0px;height:46px;' src='https://az743702.vo.msecnd.net/cdn/kofi3.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' />


### Youtube videos (Click to view and watch the playlist)
[![Youtube Playlist Thumbnail](https://raw.githubusercontent.com/JaKooLit/screenshots/main/Youtube.png)](https://youtube.com/playlist?list=PLDtGd5Fw5_GjXCznR0BzCJJDIQSZJRbxx&si=iaNjLulFdsZ6AV-t)





