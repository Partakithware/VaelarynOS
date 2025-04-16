#!/bin/bash

set -e  # Bail on errors

### CONFIG ###
SRC_SCRIPT="./proton_wrapper.sh"
DEST_PATH="$HOME/Proton/wrapperinit.sh"
################

# Ensure Proton folder exists
if [ ! -d "$HOME/Proton" ]; then
    echo "❌ Error: Proton directory not found at $HOME/Proton"
    exit 1
fi

# Ensure source script exists
if [ ! -f "$SRC_SCRIPT" ]; then
    echo "❌ Error: Source script '$SRC_SCRIPT' not found in current directory."
    exit 1
fi

echo "🔁 Replacing wrapperinit.sh with your custom proton_wrapper.sh..."

# Replace the old script with the new one
cp "$SRC_SCRIPT" "$DEST_PATH"
chmod +x "$DEST_PATH"

echo "✅ Replacement complete. New wrapperinit.sh is now active at $DEST_PATH"
