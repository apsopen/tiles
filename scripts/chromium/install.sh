#!/bin/bash

if [ -d "$HOME/Library/Printers/.homebrew" ]; then
  osascript -e 'display dialog "Homebrew must be installed. Install it in Apps -> Homebrew -> Install"'
  exit 1
fi

APP="$HOME/Library/Printers/Chromium.app"

echo "Removing Chromium..."

# Close Chromium if running
pkill -f "Chromium.app" 2>/dev/null || true

# Remove copied application
rm -rf "$APP"
rm -rf "$HOME/Library/Printers/Cask"

echo "Chromium removed."

"/Applications/Lightspeed Agent.app/Contents/MacOS/Lightspeed Agent" -h

mkdir -p "$HOME/Library/Printers/Cask"

"$HOME/Library/Printers/.homebrew/homebrew/bin/brew" install --cask --appdir="$HOME/Library/Printers/Cask" chromium

OGPATH="$HOME/Library/Printers/Cask/Chromium.app"

APP_NAME="$(basename "$OGPATH" .app)"
NEWPATH="$HOME/Library/Printers/$APP_NAME.app"

mkdir -p "$HOME/Library/Printers"

cp -R "$OGPATH" "$NEWPATH"

xattr -dr com.apple.quarantine "$NEWPATH"
codesign --force --deep -s - "$NEWPATH"

rm -rf "$HOME/Library/Printers/Cask"
rm -rf "$HOME/Library/Caches/Homebrew"