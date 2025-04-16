#!/bin/bash

# Enable debug for safety
set -euo pipefail

# 📍 Path Handling
echo "📦 Received path: '$1'"

# 🔧 Export environment variables dynamically
export STEAM_COMPAT_DATA_PATH="$HOME/Windows/"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.local/share/Steam"
export IBUS_ENABLE_SYNC_MODE=1

PROTON="$HOME/Proton/proton"

# ❗ Proton binary existence check
if [[ ! -f "$PROTON" ]]; then
    echo "❌ Proton binary not found at $PROTON"
    exit 1
fi

# 🧾 Check path arg presence
if [ -z "${1:-}" ]; then
    echo "⚠️ Error: No path provided."
    echo "Press Enter to close..."
    read
    exit 1
fi

# 🧮 List provided file
ls -l "$1"

# 🧠 Determine file type and launch accordingly
case "$1" in
    *.msi)
        echo "🛠️  Running MSI installation..."
        "$PROTON" run msiexec /i "$1"
        ;;
    *.bat)
        echo "📜 Running BAT script..."
        "$PROTON" run cmd /c "$1"
        ;;
    *.lnk)
        echo "🔗 Running LNK shortcut..."
        target=$("$PROTON" run winepath -w "$1" 2>/dev/null | tail -n 1)
        if [[ -n "$target" ]]; then
            "$PROTON" run "$target"
        else
            echo "⚠️ Could not extract target from LNK file."
        fi
        ;;
    *)
        echo "🚀 Running EXE file..."
        "$PROTON" run "$1"
        ;;
esac
