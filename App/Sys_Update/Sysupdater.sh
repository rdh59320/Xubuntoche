#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : System updater app
# Licence CREATIVE COMMONS CC BY-NC-SA 4.0
# Version : 1.1

set -e

# Function for error handling
handle_error() {
    echo "Error occurred in script at line: $1" >&2
    exit 1
}

trap 'handle_error $LINENO' ERR


# Function to update ClamAV
update_clamav() {
    echo -e "\n\n Mise à jour Base de données virales ClamAV \n\n"
    sudo systemctl stop clamav-freshclam
    sudo freshclam
    sudo systemctl start clamav-freshclam
}

# Function to update APT packages
update_apt() {
    echo -e "\n\n Mise à jour dépôts APT \n\n"
    sudo aptitude update
    sudo aptitude full-upgrade -y
    sudo apt autoremove --purge -y
    sudo apt autoclean
}

# Function to update Snap packages
update_snap() {
    echo -e "\n\n Mise à jour dépôt Snap \n\n"
    sudo snap refresh
}

# Function to update Flatpak packages
update_flatpak() {
    echo -e "\n\n Misee à jour dépôts Flatpak \n\n"
    flatpak update -y
    flatpak uninstall --unused -y
}

# Main execution
echo -e "\n Mise à Jour du Système \n"
echo "Pour mettre à jour le système: Pressez directement [Enter] "
echo "Pour quitter le programme: Pressez q/Q puis [Enter]"
read -p "Saisissez votre réponse : " request

if [[ "${request,,}" == "q" ]]; then
    echo -e "\n\n Pas de mise à jour système \n\n"
    echo -e "\n\n Au revoir ! \n\n"
    exit 0
fi

echo -e "\n\n\n Pour lancer le programme de mise à jour du Système \n\n Entrez le mot de passe suivant : \n\n LaPioche59320* \n\n Attention à ne pas mettre d'espace devant ou derrière ! \n\n"

update_clamav
update_apt
update_snap
update_flatpak

echo -e "\n\n Système entièrement mis à jour \n\n"

# Prompt for reboot
echo -e " Voulez-vous redémarrer votre ordinateur ? \n\n"
read -p "Pressez [y] ou [Y] puis [ENTER] : " rep

if [[ "${rep,,}" == "y" ]]; then
    echo -e "\n\n Redémarrage en cours \n\n"
    sleep 2
    sudo reboot
else
    echo -e "\n\n Pas de redémarrage système \n\n"
    sleep 2
fi 

exit 0
