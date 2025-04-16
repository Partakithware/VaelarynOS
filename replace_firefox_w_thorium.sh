#!/bin/bash

# Remove Firefox completely
echo ">>> Purging Firefox..."
sudo apt purge --autoremove -y firefox firefox-esr

# Verify removal
if dpkg -l | grep -q firefox; then
    echo "!!! Firefox still present. Manual removal may be needed."
else
    echo ">>> Firefox successfully removed."
fi

# Install gdebi and wget
echo ">>> Installing gdebi and wget..."
sudo apt update
sudo apt install -y gdebi wget

# Download latest Thorium Browser .deb
THORIUM_URL="https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/thorium-browser_130.0.6723.174_SSE4.deb"
THORIUM_DEB="thorium-browser.deb"

echo ">>> Downloading Thorium Browser..."
wget -O "$THORIUM_DEB" "$THORIUM_URL"

# Check download success
if [ ! -f "$THORIUM_DEB" ]; then
    echo "!!! Failed to download Thorium Browser package."
    exit 1
fi

# Install Thorium with gdebi
echo ">>> Installing Thorium Browser using gdebi..."
sudo gdebi -n "$THORIUM_DEB"
sudo update-desktop-database
echo ">>> Thorium installation complete."
