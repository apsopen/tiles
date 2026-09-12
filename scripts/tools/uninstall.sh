#!/bin/bash

(
    osascript -e 'display dialog "Remove the app from your Dock, empty your Trash, and you'\''re good!"'
    cd "$HOME/Library/Printers" || exit 1
    rm -rf *
) &
