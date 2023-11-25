<div align="center">

# 💌 ** JaKooLit's Opensuse Tumbleweed - Hyprland Install Script ** 💌

![GitHub Repo stars](https://img.shields.io/github/stars/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7) ![GitHub last commit](https://img.shields.io/github/last-commit/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=b4befe) ![GitHub repo size](https://img.shields.io/github/repo-size/JaKooLit/OpenSuse-Hyprland?style=for-the-badge&color=cba6f7)

<br/>
</div>!

### Screenshots to follow, however, dots are same as per my other Hyprland install scripts since its just using same dots
### 📷 More Screenshots [`Link`](https://github.com/JaKooLit/screenshots/tree/main/Hyprland-V2-Screenshots/General/)



## 🪧🪧🪧 ANNOUNCEMENT 🪧🪧🪧
- This Repo does not contain Hyprland Dots or configs! Dotfiles can be checked here [`Hyprland-Dots`](https://github.com/JaKooLit/Hyprland-Dots) . During installation, if you opt to copy installation, it will be downloaded from that centralized repo.
- Check out changelogs here [`Hyprland-Dots-Changelogs`](https://github.com/JaKooLit/Hyprland-Dots/blob/main/CHANGELOG.md) 

## Activating Packman Repo
- by default, the packman mirror chosen is "https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"
- if you require to change the mirror, edit install-scripts/00-packman.sh and add mirrors of your choice. you can find mirrors [HERE](http://packman.links2linux.org/mirrors)

### 🆕  Prerequisites
- This install script is intended for atleast Server type installed.
- In theory, This should work on a any Tumbleweed with DE (Plasma, Gnome, XFCE). Although I am not sure about xfce default login manager if able to detect Hyprland.

### ✨  Some notes on installation
- Some apps are being installed using OPI. These packages are wlogout, swaylock-effects and nwg-look

### ✨ Costumize the packages
- inside the install-scripts folder, you can edit 02-hypr-pkgs.sh, etc. Care though as the Hyprland Dots might not work properly
- default GTK theme if agreed to be installed is Tokyo night GTK themes (dark and light) + Tokyo night SE icons

### 🔔 NOTICE TO NVIDIA OWNERS ### 
- to follow.. for now not supported

### ✨ to run
> clone this repo by using git. Change directory, make executable and run the script
```bash
git clone https://github.com/JaKooLit/OpenSuse-Hyprland.git
cd OpenSuse-Hyprland
chmod +x install.sh
./install.sh
```
### ✨ for ZSH and OH-MY-ZSH installation
> do this once installed and script completed; do the following to change the default shell zsh
```bash
chsh -s $(which zsh)
zsh
source ~/.zshrc
```
- reboot or logout
- by default mikeh theme is installed. You can find more themes from this [`OH-MY-ZSH-THEMES`](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
- to change the theme, edit ~/.zshrc ZSH_THEME="desired theme"

### ✨ TO DO once installation done and dotfiles copied
- if you opted to install gtk themes, to apply the theme and icon, press the dark/light button (beside the padlock). To apply Bibata modern ice cursor, launch nwg-look (GTK Settings) through rofi.
- SUPER H for HINT or click on the waybar HINT! Button 
- Head over to [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/FAQ) and [TIPS](https://github.com/JaKooLit/Hyprland-Dots/wiki/TIPS)

### 🛣️ TO DO:
- [ ] Make it fully functional (duh 🤣)
- [ ] hyprland-nvidia - NOT SUPPORTED
- [ ] SDDM is not starting. However, if you opt to install zsh, I have already set for auto log-in to Hyprland so once you set up zsh like the instruction above. You just need to type username and password.

### ❗ some known issues on Hyprland-Dots
- See FAQ section of Hyprland-Dots [FAQ](https://github.com/JaKooLit/Hyprland-Dots/wiki/FAQ)

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








