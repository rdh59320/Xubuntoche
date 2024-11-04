#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : GPU compatibility check script
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

if ! command -v inxi &> /dev/null; then
    echo "inxi is not installed. Please install it and run this script again."
    exit 1
fi

GPU_INFO=$(inxi -G | grep "Device-1")

if echo "$GPU_INFO" | grep -qi "AMD"; then
    echo "AMD" > "/opt/Xubuntoche/Var/GPU"
    echo "Detected AMD GPU"
elif echo "$GPU_INFO" | grep -qi "Intel"; then
    echo "Intel" > "/opt/Xubuntoche/Var/GPU"
    echo "Detected Intel GPU"
elif echo "$GPU_INFO" | grep -qi "NVIDIA"; then
    echo "NVIDIA" > "/opt/Xubuntoche/Var/GPU"
    echo "Detected NVIDIA GPU"
else
    echo "0" > "/opt/Xubuntoche/Var/GPU"
    echo "Unsupported or unrecognized GPU detected. BeLGE supports AMD, Intel, and NVIDIA GPUs."
fi

# End script
