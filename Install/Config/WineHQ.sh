#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : WineHQ staging installation script
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

### Installation of the WineHQ PPA for the suitable distro

echo -e "\n\n Ajout des sources WineHQ pour Ubuntu \n\n"

sudo mkdir -pm755 /etc/apt/keyrings
if ! sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key; then
    echo "Échec de téléchargement de la clé WineHQ. Merci de vérifier votre connexion internet."
    exit 1
fi

# Condition to download the right PPA key according to your OS (variable OS previously generated)
Distro=$(cat "/opt/BeLGE/Var/OS")

if ! sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$Distro/winehq-$Distro.sources; then
    echo "Échec de téléchargement des sources WineHQ. Vérifiez votre connexion internet."
    exit 1
fi

echo -e "\n\n Installation de Wine-HQ staging sur le Système \n\n"
sudo apt update
if ! sudo apt install --install-recommends winehq-staging -y; then
    echo "Échec d'installation de WineHQ. Vérifiez les messages d'erreurs plus haut."
    exit 1
fi

echo "WineHQ a été installé avec succès."

# End script
