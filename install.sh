#!/bin/bash
set -euo pipefail

URL="https://github.com/apsopen/tiles/main/main.zip"
DEST="$HOME/Library/Printers/Tiles Installer.app"
TMPDIR="$(mktemp -d)"

trap 'rm -rf "$TMPDIR"' EXIT

ZIP="$TMPDIR/repo.zip"
EXTRACT="$TMPDIR/extracted"

echo "Downloading..."
curl -fL --retry 3 "$URL" -o "$ZIP"

echo "Extracting..."
mkdir -p "$EXTRACT"
ditto -x -k "$ZIP" "$EXTRACT"

APP="$(find "$EXTRACT" -type d -name 'Tiles Installer.app' -print -quit)"

if [[ -z "$APP" ]]; then
    echo "Error: Tiles Installer.app not found in ZIP." >&2
    exit 1
fi

echo "Installing..."
mkdir -p "$(dirname "$DEST")"
rm -rf "$DEST"
ditto "$APP" "$DEST"

echo "Removing quarantine..."
xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true

echo "Ad-hoc signing..."
codesign --force --deep --sign - "$DEST"

echo "Pinning to Dock..."
open -a "$DEST"
sleep 2

osascript <<'APPLESCRIPT'
tell application "System Events"
    tell process "Dock"
        try
            click UI element "Tiles Installer" of list 1
        end try
    end tell
end tell
APPLESCRIPT

killall Dock 2>/dev/null || true

echo "Installed: $DEST"