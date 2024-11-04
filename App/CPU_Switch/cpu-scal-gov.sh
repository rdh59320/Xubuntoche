#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : Script to switch between powersave and performance CPU governors
# Licence CREATIVE COMMONS CC BY-NC-SA 4.0
# Version : 1.1

set -e

# Function for error handling
handle_error() {
    echo "Erreur au cours de l'exécution du script en ligne: $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# Function to get current CPU governor
get_current_governor() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

# Function to set CPU governor
set_governor() {
    echo "$1" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    echo "Governor was switched to $1"
}

# Main script
echo "---CPU-SCALING-GOVERNOR-SWITCHER---"
echo ""
echo "Votre CPU est actuellement configuré en mode : $(get_current_governor)"
echo ""
echo "Que désirez-vous faire ?"
echo "Choisir [p] ou [P] pour Sélectionner le mode Performance"
echo "Choisir [s] ou [S] pour Sélectionner le mode Économie (Powersave) "
echo "Choisir n'importe quelle autre touche pour conserver le profil actuel"
read -p "Saisissez votre choix: " cpu_change

case "${cpu_change,,}" in
    p)
        set_governor "performance"
        ;;
    s)
        set_governor "powersave"
        ;;
    *)
        echo "Profil CPU conservé sur : $(get_current_governor)"
        ;;
esac

echo "Opération réalisée avec succès."
sleep 2
exit 0
