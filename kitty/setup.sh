#!/bin/bash

OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    kitten @ set-font-size --all 11.0
fi

CURRENT_HOUR=$(date +"%H")
SEVEN_AM=7
SEVEN_PM=19

MODE=dark
if [ $CURRENT_HOUR -ge $SEVEN_AM ] && [ $CURRENT_HOUR -lt $SEVEN_PM ]; then
    MODE=light
fi
if [ $MODE == "light" ]; then
    kitten @ set-colors --all "$HOME/.config/kitty/light.conf"
else
    kitten @ set-colors --all "$HOME/.config/kitty/dark.conf"
fi
