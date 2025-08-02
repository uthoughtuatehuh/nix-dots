#!/usr/bin/env bash

command -v mpvpaper >/dev/null 2>&1 || { echo "Error: mpvpaper not installed"; exit 1; }
command -v zenity >/dev/null 2>&1 || { echo "Error: zenity not installed"; exit 1; }
command -v hyprctl >/dev/null 2>&1 || { echo "Error: hyprctl not installed"; exit 1; }

DISPLAY=$(hyprctl monitors | grep -oP '^Monitor \K\S+' | head -n 1)
[ -z "$DISPLAY" ] && { echo "Error: could not determine display"; exit 1; }

stop_mpvpaper() {
  if pgrep -x ".mpvpaper-wrapp" > /dev/null; then
    echo "Stopping existing .mpvpaper-wrapp processes..."
    pkill .mpvpaper-wrapp
    local timeout=5
    local start_time=$(date +%s)
    while [ "$(($(date +%s) - start_time))" -lt "$timeout" ]; do
      pgrep -x ".mpvpaper-wrapp" > /dev/null || { echo "Processes .mpvpaper-wrapp stopped successfully"; return 0; }
      sleep 0.5
    done
    echo "Error: failed to stop .mpvpaper-wrapp processes"
    exit 1
  fi
}

set_wallpaper() {
  FILE=$(zenity --file-selection --title="Select wallpaper (video, GIF, or image)")
  [ -z "$FILE" ] && { echo "No file selected"; exit 1; }
  echo "Selected file: $FILE"

  EXT=$(echo "$FILE" | tr '[:upper:]' '[:lower:]' | sed 's/.*\.//')
  
  stop_mpvpaper

  case "$EXT" in
    mp4|webm|mkv|avi|gif)
      echo "Setting video wallpaper: $FILE"
      mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
      ;;
    jpg|jpeg|png|bmp)
      echo "Setting image: $FILE"
      mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
      sleep 10 && killall -q .mpvpaper-wrapper
      ;;
    *)
      echo "Error: unsupported file format ($EXT)"
      exit 1
      ;;
  esac
}

start_wallpaper() {
  LAST_WALLPAPER="$HOME/.last_wallpaper"
  [ ! -f "$LAST_WALLPAPER" ] && { echo "Error: wallpaper file not found in $LAST_WALLPAPER"; exit 1; }

  FILE=$(cat "$LAST_WALLPAPER")
  EXT=$(echo "$FILE" | tr '[:upper:]' '[:lower:]' | sed 's/.*\.//')
  echo "Autostarting file: $FILE"

  stop_mpvpaper

  case "$EXT" in
    mp4|webm|mkv|avi|gif)
      echo "Starting video wallpaper: $FILE"
      mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
      ;;
    jpg|jpeg|png|bmp)
      echo "Starting image: $FILE"
      mpvpaper -o "--hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
      sleep 10 && killall -q .mpvpaper-wrapper
      ;;
    *)
      echo "Error: unsupported file format ($EXT)"
      exit 1
      ;;
  esac
}

save_wallpaper() {
  FILE="$1"
  echo "Saving file to ~/.last_wallpaper: $FILE"
  echo "$FILE" > "$HOME/.last_wallpaper"
}

case "$1" in
  set)
    set_wallpaper
    save_wallpaper "$FILE"
    ;;
  start)
    start_wallpaper
    ;;
  *)
    echo "Usage: $0 {set|start}"
    echo "  set   - select and set wallpaper"
    echo "  start - start last wallpaper (for autostart)"
    exit 1
    ;;
esac
