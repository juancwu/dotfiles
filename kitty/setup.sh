#!/bin/bash

kitten @ set-font-size --all 11.0

CURRENT_HOUR=$(date +"%H")
SEVEN_AM=7
SEVEN_PM=19

TERM_COLOR_MODE=dark
if [ $CURRENT_HOUR -ge $SEVEN_AM ] && [ $CURRENT_HOUR -lt $SEVEN_PM ]; then
    TERM_COLOR_MODE=light
fi
if [ $TERM_COLOR_MODE == "light" ]; then
    kitten @ set-colors --all "$HOME/.config/kitty/light.conf"
else
    kitten @ set-colors --all "$HOME/.config/kitty/dark.conf"
fi

export TERM_COLOR_MODE
