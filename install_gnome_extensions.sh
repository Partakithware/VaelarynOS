#!/bin/bash

set -euo pipefail

echo "⛧ GNOME Shell Extension Essentials Installer ⛧"

REQUIRED_PKGS=(
    unzip
    gnome-shell-extensions
    gnome-shell-extension-prefs
)

echo "📦 Installing only required packages..."
sudo apt update
sudo apt install -y "${REQUIRED_PKGS[@]}"

echo "🌐 Opening GNOME Extensions pages..."

EXTENSION_URLS=(
    "https://extensions.gnome.org/extension/615/appindicator-support/"
    "https://extensions.gnome.org/extension/3628/arcmenu/"
    "https://extensions.gnome.org/extension/1160/dash-to-panel/"
)

for url in "${EXTENSION_URLS[@]}"; do
    xdg-open "$url" >/dev/null 2>&1 &
done

echo "✅ All done. Install extensions through your preferred method (browser, manual, or custom script)."
