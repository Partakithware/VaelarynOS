#!/bin/bash

echo ">>> Installing flatpak and gnome-terminal..."
sudo apt update
sudo apt install -y flatpak gnome-terminal

echo ">>> Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ">>> Creating ~/Apps directory..."
mkdir -p "$HOME/Apps"

APPIMAGE_URL="https://github.com/Partakithware/FlathubStoreUnofficial/releases/download/baselinev1.0.2/flathubstore-1.0.2.AppImage"
APPIMAGE_PATH="$HOME/Apps/flathubstore-1.0.2.AppImage"

echo ">>> Downloading Flathub Store AppImage to $APPIMAGE_PATH..."
wget -O "$APPIMAGE_PATH" "$APPIMAGE_URL"
chmod +x "$APPIMAGE_PATH"

echo ">>> Creating .desktop entry..."
DESKTOP_FILE="$HOME/.local/share/applications/FlathubStore.desktop"

mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=App Store
Comment=Launch the App Store
Exec=$APPIMAGE_PATH
Icon=software-center
Terminal=false
Type=Application
Categories=Internet;Network;System;
EOF

echo ">>> Updating desktop database..."
sudo update-desktop-database ~/.local/share/applications/

echo ">>> Purging Ubuntu's App Center (AppCenter/gnome-software)..."
sudo apt purge -y ubuntu-app-center gnome-software || echo ">>> No AppCenter or GNOME Software found, skipping..."

echo ">>> Done. Flathub Store should now appear in your application menu."
