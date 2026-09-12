#!/bin/bash

(
    cd "$HOME/Library/Printers" || exit 1
    rm -rf *
    osascript -e 'display dialog "Remove the app from your Dock, empty your Trash, and you'\''re good!"'
) &
