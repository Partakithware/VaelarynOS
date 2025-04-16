#!/bin/bash

echo ">>> Checking for Thunar and Baobab (Disk Usage Analyzer)..."

# Function to uninstall if installed
remove_if_installed() {
    PKG="$1"
    if dpkg -l | grep -q "^ii  $PKG"; then
        echo ">>> Removing $PKG..."
        sudo apt purge -y "$PKG"
    else
        echo ">>> $PKG not found, skipping..."
    fi
}

# Remove Thunar and Baobab if found
remove_if_installed thunar
remove_if_installed baobab

# Auto-remove any orphaned dependencies
echo ">>> Performing autoremove..."
sudo apt autoremove -y

# Install Nemo
echo ">>> Installing Nemo file manager..."
sudo apt update
sudo apt install -y nemo

# Optionally set Nemo as default file manager (uncomment if desired)
# echo ">>> Setting Nemo as the default file manager..."
# xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

echo ">>> Done. Thunar and Baobab removed. Nemo installed."
