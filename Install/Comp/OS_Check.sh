#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : OS compatibility check script
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

# Ubuntu version detection
if grep -q "UBUNTU_CODENAME=focal" /etc/os-release; then
    echo "focal" > "/opt/Xubuntoche/Var/OS"
    echo "Ubuntu 20.04 (Focal Fossa) détecté"
elif grep -q "UBUNTU_CODENAME=jammy" /etc/os-release; then
    echo "jammy" > "/opt/Xubuntoche/Var/OS"
    echo "Ubuntu 22.04 (Jammy Jellyfish) détecté"
elif grep -q "UBUNTU_CODENAME=noble" /etc/os-release; then
    echo "noble" > "/opt/Xubuntoche/Var/OS"
    echo "Ubuntu 24.04 (Noble Numbat) détecté"
else
    echo "0" > "/opt/Xubuntoche/Var/OS"
    echo -e "\n Le Système d'Exploitation n'est pas compatible. \n Xubuntoche nécessite Xubuntu 22.04 ou 24.04 LTS. \n"
fi

# End script
