#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : Xubuntoche package installation script
# Licence CREATIVE COMMONS CC BY-NC-SA 4.0
# Version : 1.1

set -e  # Exit immediately if a command exits with a non-zero status.

# Function for error handling
handle_error() {
    echo "Erreur au cours de l'exécution du script en ligne: $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# Begin Install script



echo -e "\n\n  Xubuntoche \n\n"
echo -e "\n\n  Le Xubuntu Configuré pour La Pioche \n\n"
sleep 3

echo -e "\n\n  Mise à jour du système \n\n et chargement des programmes utiles \n\n"

sudo apt update
sudo apt full-upgrade -y
sudo apt install -y inxi curl wget xz-utils gparted gnome-disk-utility linux-lowlatency vlc 

# Downloading package archive and extraction into the opt directory then removing archive 

#sudo cp -r BeLGE /opt/

echo -e "\n\n  Package has been downloaded and extracted \n\n"

# Making every script file executable

sudo chmod +x /opt/Xubuntoche/Install/Comp/*
sudo chmod +x /opt/Xubuntoche/Install/Config/*

### Compatibility Scripts

## OS check script
sudo bash /opt/Xubuntoche/Install/Comp/OS_Check.sh

## GPU check script
sudo bash /opt/Xubuntoche/Install/Comp/GPU_Check.sh

# Processing the compatibility test with previous scripts variables
## Getting OS and GPU check variables
OS=$(cat "/opt/BeLGE/Var/OS")
GPU=$(cat "/opt/BeLGE/Var/GPU")

# Compatibility check => if OS or GPU var is set to "0" means not compatible then stopping program

## Case either OS or GPU unsupported

if [ "$OS" = "0" ] || [ "$GPU" = "0" ]; then
    echo -e "Your system is not supported \n\n Program must stop now \n\n Package will be deleted from your system \n\n"
    sleep 1
    sudo rm -rf /opt/Xubuntoche
    sleep 3
    exit 1

## Case OS is focal fossa ==> Upgrading request
elif [ "$OS" = "focal" ]; then
    echo -e "\n\n Ubuntu 20.04 Focal Fossa is no longer supported \n\n Please, you must first upgrade your OS before running BeLGE program \n\n Program have to stop now. \n\n"
    sleep 1
    sudo rm -rf /opt/Xubuntoche
    sleep 3
    exit 1
fi

## Confirmation request of the package installation

echo -e "\n\n\n  Your system is suitable for installation \n\n\n Would you like to continue installation of the package? \n Type q or Q then press [ENTER] to exit installation \n"
read -p " Or press Any Other Key to Continue [DEFAULT] : " repinstall

if [ "$repinstall" = "q" ] || [ "$repinstall" = "Q" ]; then
    echo -e "\n\n Installation has been aborted \n\n Program will shut down now and \n\n Package will be deleted from your system \n\n"
    sleep 1
    sudo rm -rf /opt/Xubuntoche
    sleep 3
    exit 0
fi

# System configuration script
sudo bash /opt/Xubuntoche/Install/Config/Sys_Config.sh

# WineHQ configuration script
bash /opt/Xubuntoche/Install/Config/WineHQ.sh

# System Customization
bash /opt/Xubuntoche/Install/Config/Sys_Custom.sh


# Chromium

echo -e "\n\n Installation navigateur web Chromium \n\n"
sudo snap install chromium chromium-ffmpeg

# Programmes Flatpak
echo -e "\n\n Installation des pacquets Flatpak \n\n"

flatpak install org.onlyoffice.desktopeditors -y
flatpak install flathub com.github.PintaProject.Pinta -y
flatpak install flathub org.kde.krita -y

# Rustdesk pour assistance à distance
echo -e "\n\n Installation de RustDesk \n\n"

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.1/rustdesk-1.3.1-x86_64.deb -O rustdesk.deb

sleep 1
sudo gdebi -n rustdesk.deb
sleep 1
rm rustdesk.deb

# Last update then reboot

echo -e "\n\n System is now prepared \n\n"

echo -e "\n\n\n Desktop shortcuts added to finalize \n\n" 

echo -e "\n\n BeLGE package Installation complete \n\n"

echo -e "\n\n\n Last Update before Restart \n\n\n"

sudo aptitude update
sudo aptitude full-upgrade -y
sudo apt autoremove --purge -y

echo -e "\n\n\n System update complete. Ready for reboot \n\n\n"

read -p " Press any key to launch the system reboot : " reboot

echo -e "\n\n System is rebooting \n\n"
sleep 1 && sudo reboot

# End script
