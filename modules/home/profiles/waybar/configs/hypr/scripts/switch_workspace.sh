#!/usr/bin/env bash

# Получаем текущий рабочий стол
CURRENT_WS=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')

# Определяем направление переключения
if [ "$1" == "next" ]; then
  NEW_WS=$((CURRENT_WS + 1))
  if [ $NEW_WS -gt 10 ]; then
    NEW_WS=1
  fi
elif [ "$1" == "prev" ]; then
  NEW_WS=$((CURRENT_WS - 1))
  if [ $NEW_WS -lt 1 ]; then
    NEW_WS=10
  fi
else
  echo "Invalid argument. Use 'next' or 'prev'."
  exit 1
fi

# Переключаемся на новый рабочий стол
hyprctl dispatch workspace $NEW_WS
