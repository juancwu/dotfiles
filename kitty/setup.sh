#!/bin/bash

OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    kitten @ set-font-size --all 9.0
fi

# get the SUNRISE/SUNSET time for the day
DATE_FILE=$HOME/.config/kitty/date_output.txt
CURRENT_DATE=$(date +"%B %d")
LOCATION=c5326b3950212c71c67cee42b213313f555df223d9668aabb44c6719dc67685c
TMP_FILE=$HOME/.config/kitty/$LOCATION.html
SUNRISE_CACHE=$HOME/.config/kitty/$LOCATION.SUNRISE
SUNSET_CACHE=$HOME/.config/kitty/$LOCATION.SUNSET

time_to_minutes() {
    local time=$1
    local hours=${time%:*}
    local minutes=${time#*:}
    echo $((10#$hours * 60 + 10#$minutes))
}

get_sunrise_sunset() {
    wget -q "https://weather.com/weather/today/l/$LOCATION" -O "$TMP_FILE"

    SUNR=$(rg SunriseSunset "$TMP_FILE" | rg -o '((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))' | head -1)
    SUNS=$(rg SunriseSunset "$TMP_FILE" | rg -o '((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))' | tail -1)
    echo $SUNR
    echo $SUNS

    SUNRISE=$(date --date="$SUNR" +%R)
    SUNSET=$(date --date="$SUNS" +%R)
    echo $SUNRISE
    echo $SUNSET

    echo "$SUNRISE" > $SUNRISE_CACHE
    echo "$SUNSET" > $SUNSET_CACHE
}

get_sunrise_sunset_from_cache() {
    read -r SUNRISE < $SUNRISE_CACHE
    read -r SUNSET < $SUNSET_CACHE
}

if [ -f "$DATE_FILE" ]; then
    STORED_DATE=$(bat "$DATE_FILE")
    if [ "$STORED_DATE" != "$CURRENT_DATE" ]; then
        echo "$CURRENT_DATE" > "$DATE_FILE"
        get_sunrise_sunset
    else
        get_sunrise_sunset_from_cache
    fi
else
    echo "$CURRENT_DATE" > "$DATE_FILE"
    get_sunrise_sunset
fi

MODE=dark
NOW=$(date +"%H%M")
SUNRISE_MINUTES=${SUNRISE/':'/}
SUNSET_MINUTES=${SUNSET/':'/}
if [ $NOW -ge $SUNRISE_MINUTES ] && [ $NOW -lt $SUNSET_MINUTES ]; then
    MODE=light
fi
if [ $MODE == "light" ]; then
    echo "load light theme"
else
    echo "load dark theme"
fi
