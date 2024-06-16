#!/bin/zsh

kitten @ set-font-size --all 16.0

TERM_COLOR_MODE=dark

command -v asadesuka > /dev/null 2>&1
if [ $? -eq 0 ]; then
    IS_ASA=$(asadesuka -offset=30)
    if [ "$IS_ASA" = "true" ]; then
        TERM_COLOR_MODE=light
    fi
else
    CURRENT_HOUR=$(date +"%H")
    SEVEN_AM=7
    SEVEN_PM=19
    if [ $CURRENT_HOUR -ge $SEVEN_AM ] && [ $CURRENT_HOUR -lt $SEVEN_PM ]; then
        TERM_COLOR_MODE=light
    fi
fi

if [ "$TERM_COLOR_MODE" = "light" ]; then
    kitten @ set-colors --all "$HOME/.config/kitty/light.conf"
else
    kitten @ set-colors --all "$HOME/.config/kitty/dark.conf"
fi

export TERM_COLOR_MODE
