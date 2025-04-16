#!/bin/bash

set -e  # Exit on error globally (still keeps it for critical errors)

echo "🔧 Installing required runtime dependencies for Proton..."

# Disable `set -e` temporarily to allow non-critical failures during package installation
set +e

# Core runtime, Vulkan, DXVK essentials
sudo apt update && sudo apt install -y \
    curl \
    wget \
    fuse \
    python3 \
    python3-pip \
    mesa-vulkan-drivers \
    libvulkan1 \
    libgl1 \
    libnss3 \
    libudev1 \
    libx11-6 \
    libxrandr2 \
    libxinerama1 \
    libxss1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrender1 \
    libgtk-3-0t64 \
    libdbus-1-3 \
    libasound2t64 \
    libpulse0 \
    cabextract

# Re-enable `set -e` to exit on critical errors
set -e

echo "✅ Minimal dependencies for Proton installed."

# Wait for user input to continue
read -n1 -r -p "Press any key to continue..."
echo
