#!/bin/sh

while true; do
    if command -v xkb-switch >/dev/null 2>&1; then
        LAYOUT=$(xkb-switch -p | tr 'a-z' 'A-Z')
    else
        LAYOUT=$(setxkbmap -print | grep xkb_symbols | awk -F'+' '{print $2}' | cut -c1-2 | tr 'a-z' 'A-Z')
    fi
    LAYOUT=${LAYOUT:-EN}
    
    MEM=$(free -h | awk '/^Mem/ {print $3"/"$2}')
    
    TIME=$(date '+%H:%M')
    
    status="[$LAYOUT] | $MEM | $TIME"
    
    xsetroot -name "$status"
    sleep 1
done
