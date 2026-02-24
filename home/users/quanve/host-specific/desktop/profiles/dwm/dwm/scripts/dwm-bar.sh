#!/bin/sh

while true; do
    # Правильное определение текущей раскладки
    # Используем xkb-switch или xkbmon, если установлены
    if command -v xkb-switch >/dev/null 2>&1; then
        LAYOUT=$(xkb-switch -p | tr 'a-z' 'A-Z')
    else
        # Альтернативный метод через xset
        LAYOUT=$(setxkbmap -print | grep xkb_symbols | awk -F'+' '{print $2}' | cut -c1-2 | tr 'a-z' 'A-Z')
    fi
    LAYOUT=${LAYOUT:-EN}
    
    # Память
    MEM=$(free -h | awk '/^Mem/ {print $3"/"$2}')
    
    # Время
    TIME=$(date '+%H:%M')
    
    # Формируем статус
    status="[$LAYOUT] | $MEM | $TIME"
    
    xsetroot -name "$status"
    sleep 1
done
