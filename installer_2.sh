#!/bin/bash

# Update apt and install the required packages
echo "Updating package list and installing dependencies..."
sudo apt update && sudo apt install -y python3 git make cmake g++ clang \
    libdbus-1-dev libgl1-mesa-dev libvulkan-dev libx11-dev libxrandr-dev \
    libxinerama-dev libxcursor-dev libxi-dev libxext-dev libfreetype6-dev \
    libfontconfig1-dev libxcomposite-dev libxdamage-dev libxfixes-dev \
    libxrender-dev libsm-dev libudev-dev libwayland-dev libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev libpulse-dev libopenal-dev wine64 wine32

if [ $? -ne 0 ]; then
    echo "Error installing dependencies. Exiting."
    exit 1
fi

# Define the desktop file path
desktop_file="$HOME/.local/share/applications/Proton.desktop"

# Get the current user's username
username=$(whoami)

# Create the Proton.desktop file
echo "Creating Proton.desktop file..."
cat > "$desktop_file" <<EOL
[Desktop Entry]
Name=Run Windows File
Exec=bash -c "/home/$username/Proton/wrapperinit.sh %f"
Type=Application
MimeType=application/x-ms-dos-executable;application/x-msdownload;application/x-msi;
NoDisplay=false
Terminal=false
Icon=steam
Categories=Utility;Application;
EOL

if [ $? -ne 0 ]; then
    echo "Error creating Proton.desktop file. Exiting."
    exit 1
fi

# Update the desktop database
echo "Updating desktop database..."
update-desktop-database ~/.local/share/applications/

if [ $? -ne 0 ]; then
    echo "Error updating desktop database. Exiting."
    exit 1
fi

# Set Proton as the default for .exe and .msi files
echo "Setting Proton as the default for .exe and .msi files..."
xdg-mime default Proton.desktop application/x-ms-dos-executable
xdg-mime default Proton.desktop application/x-msi

if [ $? -ne 0 ]; then
    echo "Error setting default MIME types. Exiting."
    exit 1
fi

# Update the desktop database again after MIME type change
update-desktop-database ~/.local/share/applications/

echo "Installation completed successfully!"
