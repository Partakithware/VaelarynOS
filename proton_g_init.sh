#!/bin/bash

set -e  # Cease on any blasphemous error

### CONFIGURATION SIGILS ###
PROTON_DEST="$HOME/Proton"
SQUASHFS_FILE="proton.sqfs"
MEGA_URL="https://mega.nz/file/KSZniJCS#Nb8X32HrmWY4Qz45KJzHDr32M6idH6akj-qDfWyZa-k"
EXPECTED_HASH="fa2205707057804956051661244ed1eae7cc1154a9926218dfdd8d9ee06d8960"
TMPDIR="/tmp/vaelaryn"
################################

echo "⛧ VaelarynOS: Proton 9.4 Setup ⛧"

# Ensure sacred tools are present
require_or_install() {
    local cmd="$1"
    local pkg="$2"

    if ! command -v "$cmd" >/dev/null; then
        echo "❌ '$cmd' is not installed. Required for this script."
        read -p "🛠️  Would you like to install '$pkg'? [Y/n]: " choice
        case "$choice" in
            [nN]*) 
                echo "🚫 Cannot proceed without '$cmd'. Exiting."
                exit 1
                ;;
            *) 
                echo "📦 Installing '$pkg'..."
                sudo apt update && sudo apt install -y "$pkg"
                ;;
        esac
    fi
}

# Invoke the checks
require_or_install "megadl" "megatools"
require_or_install "unsquashfs" "squashfs-tools"

# Conjure temp dir
mkdir -p "$TMPDIR"
cd "$TMPDIR"

echo "🔻 Summoning Proton module from MEGA repository..."
megadl "$MEGA_URL"

# Find the actual downloaded file, since megadl just dumps it here
DOWNLOADED_FILE=$(find "$TMPDIR" -maxdepth 1 -type f -name "*.sqfs" | head -n 1)

if [[ -z "$DOWNLOADED_FILE" ]]; then
    echo "❌ The Squashed Codex was not conjured properly. No *.sqfs found."
    exit 1
fi

# Integrity Verification Ritual
if [[ -n "$EXPECTED_HASH" ]]; then
    echo "🧪 Performing SHA256 sanctification of $DOWNLOADED_FILE..."
    ACTUAL_HASH=$(sha256sum "$DOWNLOADED_FILE" | awk '{print $1}')
    if [[ "$ACTUAL_HASH" != "$EXPECTED_HASH" ]]; then
        echo "❌ ✖️ Corruption Detected: Hash Mismatch"
        echo "Expected: $EXPECTED_HASH"
        echo "Actual:   $ACTUAL_HASH"
        echo "☠️ Installation aborted. Purge the foul artifact and try again."
        exit 1
    fi
    echo "✅ Integrity affirmed. Proceeding."
fi

# Decompression of the Codex
echo "📦 Extracting the Squashed Codex into $PROTON_DEST..."
mkdir -p "$PROTON_DEST"
sudo unsquashfs -f -d "$PROTON_DEST" "$DOWNLOADED_FILE"
sudo chown -R "$USER:$USER" "$PROTON_DEST"

# Verify essence of Proton
if [[ ! -f "$PROTON_DEST/proton" && ! -x "$PROTON_DEST/dist/bin/proton" ]]; then
    echo "⚠️  Warning: Proton binary not found in expected locations."
    echo "👁️  Investigate manually: $PROTON_DEST"
else
    echo "✅ The Protonic Core has been bound into place: $PROTON_DEST"
fi
