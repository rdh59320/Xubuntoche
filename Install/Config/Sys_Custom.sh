#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : BeLGE package application and customization script
# Licence CREATIVE COMMONS CC BY-NC-SA 4.0
# Version : 1.1

set -e  # Exit immediately if a command exits with a non-zero status.

# Function for error handling
handle_error() {
    echo "Erreur au cours de l'exécution du script en ligne: $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# Begin script

## Adding new sudoers file to add password feedback in termineal
sudo cp -f /opt/Xubuntoche/Install/Resources/sudoers /etc/sudoers
sudo chown root /etc/sudoers

## Xterm configuration for apps use
sudo cp /opt/Xubuntoche/Install/Resources/.Xresources ~/.Xresources
sudo chown $USER:$USER ~/.Xresources
xrdb -merge ~/.Xresources

## Adding new apps on the system

# Defining path to desktop to send a desktop shortcut
Desktop_path=$(xdg-user-dir DESKTOP)

## Copy destop shortcut to Desktop and applications directories with change of owner and allowing exection
### SysUpdater
sudo cp /opt/Xubuntoche/App/Sys_Update/Sysupdater.desktop $Desktop_path
sudo chown $USER $Desktop_path/Sysupdater.desktop
sudo chmod a+x $Desktop_path/Sysupdater.desktop

sudo cp /opt/Xubuntoche/App/Sys_Update/Sysupdater.desktop /usr/share/applications 
sudo chown $USER:$USER /usr/share/applications/Sysupdater.desktop 
sudo chmod a+x /usr/share/applications/Sysupdater.desktop

### CPU Switcher
sudo cp /opt/Xubuntoche/App/CPU_Switch/CPU_switch.desktop $Desktop_path 
sudo chown $USER:$USER $Desktop_path/CPU_switch.desktop
sudo chmod a+x $Desktop_path/CPU_switch.desktop

sudo cp /opt/Xubuntoche/App/CPU_Switch/CPU_switch.desktop /usr/share/applications 
sudo chown $USER:$USER /usr/share/applications/CPU_switch.desktop 
sudo chmod a+x /usr/share/applications/CPU_switch.desktop

### KVRT
sudo chmod a+x /opt/BeLGE/App/KVRT/kvrt.run

sudo cp /opt/Xubuntoche/App/KVRT/KVRT.desktop $Desktop_path 
sudo chown $USER:$USER $Desktop_path/KVRT.desktop
sudo chmod a+x $Desktop_path/KVRT.desktop

sudo cp /opt/Xubuntoche/App/KVRT/KVRT.desktop /usr/share/applications 
sudo chown $USER:$USER /usr/share/applications/KVRT.desktop 
sudo chmod a+x /usr/share/applications/KVRT.desktop

echo -e "\n\n Les Apps Xubuntoche ont été installées avec succès \n\n"

## Grub customization
sudo mkdir -p /boot/grub/Images
sudo cp /opt/Xubuntoche/Install/Resources/Ubuntu-la-Pioche.jpg /boot/grub/Images/
sudo cp -f /opt/Xubuntoche/Install/Resources/grub /etc/default/grub
sudo update-grub

echo -e "\n\n Personnalisation du Système effectuée avec succès \n\n"

# End script
