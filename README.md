<div align="center">

## 💌 ** JaKooLit's Opensuse Tumbleweed - Hyprland Install Script ** 💌

![GitHub Repo stars](https://img.shields.io/github/stars/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7) ![GitHub last commit](https://img.shields.io/github/last-commit/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=b4befe) ![GitHub repo size](https://img.shields.io/github/repo-size/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7) <a href="https://discord.gg/V2SJ92vbEN"> <img src="https://img.shields.io/discord/1151869464405606400?style=for-the-badge&logo=discord&color=cba6f7&link=https%3A%2F%2Fdiscord.gg%2V2SJ92vbEN"> </a>

<br/>
</div>

<h3 align="center">
	<img src="https://github.com/JaKooLit/Telegram-Animated-Emojis/blob/main/Activity/Sparkles.webp" alt="Sparkles" width="38" height="38" />
	KooL Hyprland-Dotfiles Showcase 
	<img src="https://github.com/JaKooLit/Telegram-Animated-Emojis/blob/main/Activity/Sparkles.webp" alt="Sparkles" width="38" height="38" />
</h3>

<div align="center">

https://github.com/JaKooLit/Hyprland-Dots/assets/85185940/50d53755-0f11-45d6-9913-76039e84a2cd

</div>

### Gallery and Videos
<details>
<summary>
📷 Screenshots
</summary>
#### 📷 Some Screenshots
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

#### 📷 More Screenshots (from other distros since it it using same Hyprland Dots) [`Link`](https://github.com/JaKooLit/screenshots/tree/main/Hyprland-V2-Screenshots/General/)
</summary>

#### 📹 Video presentation [`Youtube Link`](https://youtu.be/xmSW9W-MbME?si=h9p8b8Z_GmsgafRS)


### 🪧🪧🪧 ANNOUNCEMENT 🪧🪧🪧
- This Repo does not contain Hyprland Dots or configs! Dotfiles can be checked here [`Hyprland-Dots`](https://github.com/JaKooLit/Hyprland-Dots) . During installation, if you opt to copy installation, it will be downloaded from that centralized repo.
- Hyprland-Dots use are constantly evolving / improving. you can check CHANGELOGS here [`Hyprland-Dots-Changelogs`](https://github.com/JaKooLit/Hyprland-Dots/wiki/Changelogs)
- Since the Hyprland-Dots are evolving, some of the screenshots maybe old
- the wallpaper offered to be downloaded towards the end is from this [`REPO`](https://github.com/JaKooLit/Wallpaper-Bank)

### ♨️ Activating Packman Repo
- by default, the packman mirror chosen is "https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"
- if you require to change the mirror, edit install-scripts/00-packman.sh and add mirrors of your choice. you can find mirrors [HERE](http://packman.links2linux.org/mirrors)

> [!IMPORTANT]
> install a backup tool like `snapper` or `timeshift`. and Backup your system before installing hyprland using this script. This script does NOT include uninstallation of packages

> [!NOTE]
> Main reason why I have not included an uninstallation script is simple. Some packages maybe already installed on your system by default. If I create an uninstall script with packages that I have set to install, you may end up a unrecoverable system. 

> [!WARNING] 
> Download this script on a directory where you have write permissions. ie. HOME. Or any directory within your home directory. Else script will fail

#### 🆕  Prerequisites
- This install script is intended for atleast Server type installed.
- In theory, This should work on a any Tumbleweed with DE (Plasma, Gnome, XFCE). Although I am not sure about xfce default login manager if able to detect Hyprland.
- If you have nvidia, and wanted to use proprietary drivers, uninstall nouveau first (if installed). This script will be installing proprietary nvidia drivers and will not deal with removal of nouveau.

#### ✨  Some notes on installation
- Some apps are being installed using OPI. These packages are wlogout, swaylock-effects and nwg-look
- for SDDM, by script sddm-qt6 will be installed. If you have already sddm, I HIGHLY SUGGEST NOT to install sddm through this script since I dont know the impact to your current sddm. Opensuse ship 2 version, sddm and sddm-qt6. The latter is more up to date... (I think)
- Another for SDDM, if you are installing from a server type of opensuse install, I highly suggest to install the sddm theme since you'll get a vanilla look sddm theme. 

#### ✨ Costumize the packages
- inside the install-scripts folder, you can edit 02-hypr-pkgs.sh, etc. Care though as the Hyprland Dots might not work properly
- default GTK theme if agreed to be installed is Tokyo night GTK themes (dark and light) + Tokyo night SE icons

#### 💫 SDDM and GTK Themes offered
- If you opted to install SDDM theme, here's the [`LINK`](https://github.com/JaKooLit/simple-sddm)
- If you opted to install GTK Themes, Icons and Cursor offered are Tokyo Nights. [`LINK`](https://github.com/JaKooLit/GTK-themes-icons) & Bibata Cursor Modern Ice 

#### ⚠️ WARNING! If you have GDM already as log-in manager, DO NOT install SDDM
- You will likely to encounter issues

#### 🔔 NOTICE TO NVIDIA OWNERS ### 
- Please take note that the nvidia driver will be install is G06 driver, which is for GeForce 700 series (Maxwell, Pascal...) and up see here [`NVIDIA-Opensuse-Link`](https://en.opensuse.org/SDB:NVIDIA_drivers)
- You can edit the install-scripts/nvidia.sh if you require for older cards. However, do take note that it may not work as older nvidia drivers dont support wayland well.
> [!IMPORTANT]
> If you want to use nouveau driver, choose N when asked if you have nvidia gpu. This is because the nvidia installer part, it will blacklist nouveau. Hyprland will still be installed but it will skip blacklisting nouveau.
- NVIDIA users / owners, after installation, check [`THIS`](https://github.com/JaKooLit/Hyprland-Dots/wiki/Notes_to_remember#--for-nvidia-gpu-users)

#### 🔔 NOTICE TO ASUS ROG Laptop owners ### 
- There is an guide by Asusctl dev [`Asusctl`](https://asus-linux.org/wiki/opensuse-guide/)
- However. during my test, the ROG gui is not behaving well, and I cant click any button. So The asusctl and supergfxctl that I have set here are build from source through their gitlab

#### ✨ to run
> clone this repo (latest commit only) to reduce file size download by using git. Change directory, make executable and run the script
```bash
git clone --depth=1 https://github.com/JaKooLit/OpenSuse-Hyprland.git ~/OpenSuse-Hyprland
cd ~/OpenSuse-Hyprland
chmod +x install.sh
./install.sh
```

<p align="center">
    <img align="center" width="100%" src="https://raw.githubusercontent.com/JaKooLit/OpenSuse-Hyprland/main/OpenSuse-Installer.png" />

#### ✨ for ZSH and OH-MY-ZSH installation
> installer should auto change your default shell to zsh. However, if it does not, do this
```bash
chsh -s $(which zsh)
zsh
source ~/.zshrc
```
- reboot or logout
- by default agnoster theme is installed. You can find more themes from this [`OH-MY-ZSH-THEMES`](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
- to change the theme, edit ~/.zshrc ZSH_THEME="desired theme"

#### ✨ TO DO once installation done and dotfiles copied
- ~~if you opted to install gtk themes, to apply the theme and icon, press the dark/light button (beside the padlock). To apply Bibata modern ice cursor, launch nwg-look (GTK Settings) through rofi.~~ Hyprland-Dots v2.1.18, initial boot file will attempt to apply GTK themes,cursor, and icons. You can tweak more using nwg-look (GTK-Settings) utility

- SUPER H for HINT or click on the waybar HINT! Button 
- Head over to [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/FAQ) and [TIPS](https://github.com/JaKooLit/Hyprland-Dots/wiki/TIPS)

#### 🙋 Got a questions regarding the Hyprland Dots or configurations? 🙋
- Head over to wiki Link [`WIKI`](https://github.com/JaKooLit/Hyprland-Dots/wiki)

#### 🙋 👋 Having issues or questions? 
- for the install part, kindly open issue on this repo
- for the Pre-configured Hyprland dots / configuration, submit issue [`here`](https://github.com/JaKooLit/Hyprland-Dots/issues)

#### ❗ some known issues on this Installer
- some users reported that they have to install some packages. It is in the install-scripts/force-install.sh
- At this time the packages force to install are the following `playerctl`

#### ✨ Packages that are manually downloaded and build. These packages will not be updated by dnf and have to be manually updated
- wallust [`LINK`](https://codeberg.org/explosion-mental/wallust)

#### ❗ some known issues for nvidia
- reports from members of my discord, states that some users of nvidia are getting stuck on sddm login. credit  to @Kenni Fix stated was 
```  
 while in sddm press ctrl+alt+F2 or F3
log into your account
`lspci -nn`, find the id of your nvidia card
`ls /dev/dri/by-path` find the matching id
`ls -l /dev/dri/by-path` to check where the symlink points to 
)
```
- add "env = WLR_DRM_DEVICES,/dev/dri/cardX" to the ENVvariables config (.config/hypr/UserConfigs/ENVariables.conf)  ; X being where the symlink of the gpu points to

- more info from the hyprland wiki [`Hyprland Wiki Link`](https://wiki.hyprland.org/FAQ/#my-external-monitor-is-blank--doesnt-render--receives-no-signal-laptop)

#### 🔧 Proper way to re-installing a particular script from install-scripts folder
- CD into Fedora-Hyprland Folder and then ran the below command. 
- i.e. `./install-scripts/gtk-themes` - For reinstall GTK Themes. 

#### 🛣️ TO DO:
- ~~[ ] Install zsh and oh-my-zsh without necessary steps above~~ DONE 
- ~~[ ] Make it fully functional (duh 🤣)~~ done
- ~~[ ] hyprland-nvidia - NOT SUPPORTED~~ NOW SUPPORTED 🥳
- ~~[ ] SDDM is not starting. However, if you opt to install zsh, I have already set for auto log-in to Hyprland so once you set up zsh like the instruction above. You just need to type username and password.~~ FIXED 🥳

#### 🫥 Improving performance for Older Nvidia Cards using driver 470
  - [`SEE HERE`](https://github.com/JaKooLit/Hyprland-Dots/discussions/123#discussion-6035205)
  
#### ❗ some known issues on Hyprland-Dots
- See FAQ section of Hyprland-Dots [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/FAQ)


#### ⏩ Contributing
- As stated above, these script does not contain actual config files. These are only the installer of packages
- The development branch of this script is pulling the latest "stable" releases of the Hyprland-Dotfiles.
- If you want to contribute and/or test the Hyprland-Dotfiles (development branch), [`Hyprland-Dots-Development`](https://github.com/JaKooLit/Hyprland-Dots/tree/development) 


#### 📒 Final Notes
- join my discord channel [`Discord`](https://discord.gg/V2SJ92vbEN)
- Feel free to copy, re-distribute, and use this script however you want. Would appreciate if you give me some loves by crediting my work :)

#### 👍👍👍 Thanks and Credits!
- [`Hyprland`](https://hyprland.org/) Of course to Hyprland and @vaxerski for this awesome Dynamic Tiling Manager.

### 💖 Support
- a Star on my Github repos would be nice 🌟

- Subscribe to my Youtube Channel [YouTube](https://www.youtube.com/@Ja.KooLit) 

- You can also buy me Coffee Through ko-fi.com or coffee.com 🤩

<a href='https://ko-fi.com/jakoolit' target='_blank'><img height='35' style='border:0px;height:46px;' src='https://az743702.vo.msecnd.net/cdn/kofi3.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' />

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/JaKooLit)

#### 📹 Youtube videos (Click to view and watch the playlist) 📹
[![Youtube Playlist Thumbnail](https://raw.githubusercontent.com/JaKooLit/screenshots/main/Youtube.png)](https://youtube.com/playlist?list=PLDtGd5Fw5_GjXCznR0BzCJJDIQSZJRbxx&si=iaNjLulFdsZ6AV-t)

## 🥰🥰 💖💖 👍👍👍
[![Stargazers over time](https://starchart.cc/JaKooLit/OpenSuse-Hyprland.svg?variant=adaptive)](https://starchart.cc/JaKooLit/OpenSuse-Hyprland)

                    





