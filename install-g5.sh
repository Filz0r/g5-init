#!/usr/bin/env bash

START_PWD=$(pwd)
SECONDS=0
echo "Creating required folders"
if [[ ! -d ~/.config ]]; then mkdir ~/.config; fi
if [[ ! -d ~/Documents ]]; then mkdir ~/Documents; fi
if [[ ! -d ~/Pictures ]]; then mkdir ~/Pictures; fi
if [[ ! -d ~/Downloads ]]; then mkdir ~/Downloads; fi
if [[ ! -d ~/github ]]; then mkdir ~/github; fi
if [[ ! -d ~/code ]]; then mkdir ~/code; fi
if [[ ! -d ~/.local ]]; then mkdir ~/.local; fi
mkdir ~/.local/bin

sudo cp pacman.conf /etc/pacman.conf
sudo pacman-key --init
sudo pacman-key --populate archlinux

sudo pacman -Sy --needed --noconfirm emacs kitty nautilus discord firefox gparted \
    kdeconnect yad gimp nvidia-settings nitrogen transmission-remote-qt \
    arandr xorg-xrandr bash-completion bluez bluez-utils bpytop  cockpit cockpit-pcp \
    nmap wireguard-tools vim chromium evolution gnome-keyring capitaine-cursors \
    lxappearance i3-gaps neofetch syncthing stress shellcheck s-tui \
    ttf-font-awesome ttf-nerd-fonts-symbols intel-undervolt iotop tree \
    w3m vlc wireguard-tools ripgrep rofi dmenu qtile telegram-desktop cpupower 
    gnome-disk-utility polkit-gnome filezilla xterm mpv pavucontrol bitwarden \
    xorg sddm plasma steam gnome-calculator nvidia-dkms nvidia-utils \
    lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader \
    lib32-mesa vulkan-intel lib32-vulkan-intel wine-staging giflib \
    lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls \
    lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils \
    libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins \
    lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
    sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt \
    libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader  \
    lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 \
    lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs nvidia-prime

# installs yay as an AUR helper
echo "installing AUR helper"
git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -si
cd $START_PWD || exit 1
sleep 5
# installs AUR packages
echo
echo "Installing AUR packages"
yay -S exodus github-desktop-bin i3exit cpupower-gui \
    js-beautify moka-icon-theme-git mongodb-compass nvm \
    picom-jonaburg-git polybar polybar-spotify-module spotify tela-icon-theme \
    timeshift-bin vscodium zoom heroic-games-launcher-bin gwe optimus-manager \
    optimus-manager-qt gamemode mangohud auto-cpufreq gitkraken

#installs Doom Emacs
echo
echo "Installing Doom Emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

sudo systemctl enable sddm cockpit bluetooth NetworkManager auto-cpufreq

# copies and symlinks dotfiles to .mySettings
sleep 5
echo
echo "Applying initial structure"
cp -rp ./configs/* ~/.config/
cp -rp ./scripts/* ~/scripts/
# small cleanup and creation of directories
rm ~/.bash_aliases ~/.bashrc ~/.gtkrc-2.0
echo
echo "Symlinking files to home directory"
cp ./bashrc ~/.bashrc
sudo cp ./optimus-manager.conf /etc/optimus-manager/optimus-manager.conf
mv ./Wallpapers $HOME/Pictures/Wallpapers
mv ./scripts $HOME/scripts
mv configs/kitty $HOME/.config/kitty


#cp ./aliases ~/.bash_aliases
#ln -s $START_PWD/gtkrc ~/.gtkrc-2.0
echo
echo "Applying doom emacs configs"
cp doom/* ~/.doom.d/
~/.emacs.d/bin/doom sync
