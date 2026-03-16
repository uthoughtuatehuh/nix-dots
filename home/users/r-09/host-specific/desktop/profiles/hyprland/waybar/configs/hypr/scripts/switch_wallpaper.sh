#!/usr/bin/env bash

command -v mpvpaper >/dev/null 2>&1 || { echo "Error: mpvpaper not installed"; exit 1; }
command -v zenity >/dev/null 2>&1 || { echo "Error: zenity not installed"; exit 1; }
command -v hyprctl >/dev/null 2>&1 || { echo "Error: hyprctl not installed"; exit 1; }

DISPLAY=$(hyprctl monitors | grep -oP '^Monitor \K\S+' | head -n 1)
[ -z "$DISPLAY" ] && { echo "Error: could not determine display"; exit 1; }

LAST_WALLPAPER="$HOME/.last_wallpaper"
PIDFILE="/tmp/wallpaper.pid"

stop_mpvpaper() {
  if pgrep -f "mpvpaper" > /dev/null; then
    echo "Stopping existing mpvpaper processes..."
    pkill -f "mpvpaper"
    local timeout=5
    local start_time=$(date +%s)
    while [ "$(($(date +%s) - start_time))" -lt "$timeout" ]; do
      pgrep -f "mpvpaper" > /dev/null || { echo "mpvpaper stopped successfully"; rm -f "$PIDFILE"; return 0; }
      sleep 0.5
    done
    echo "Warning: force killing mpvpaper"
    pkill -9 -f "mpvpaper"
    rm -f "$PIDFILE"
  fi
}

set_wallpaper() {
  FILE=$(zenity --file-selection --title="Select wallpaper (video, GIF, or image)")
  [ -z "$FILE" ] && { echo "No file selected"; exit 1; }
  echo "Selected file: $FILE"

  EXT=$(echo "$FILE" | tr '[:upper:]' '[:lower:]' | sed 's/.*\.//')
  
  stop_mpvpaper
  echo "$FILE" > "$LAST_WALLPAPER"
  
  case "$EXT" in
    mp4|webm|mkv|avi|gif|jpg|jpeg|png|bmp)
      echo "Starting wallpaper: $FILE"
      mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
      echo $! > "$PIDFILE"
      ;;
    *)
      echo "Error: unsupported file format ($EXT)"
      exit 1
      ;;
  esac
}

start_wallpaper() {
  if [ "$1" = "daemon" ]; then
    echo "Starting wallpaper daemon mode"
    
    if [ ! -f "$LAST_WALLPAPER" ]; then
      echo "Error: no wallpaper file found in $LAST_WALLPAPER"
      exit 1
    fi
    
    FILE=$(cat "$LAST_WALLPAPER")
    [ ! -f "$FILE" ] && { echo "Error: wallpaper file not found: $FILE"; exit 1; }
    
    echo "Starting wallpaper: $FILE"
    mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
    MPVPID=$!
    echo $MPVPID > "$PIDFILE"
    
    while true; do
      if ! kill -0 $MPVPID 2>/dev/null; then
        echo "mpvpaper died, restarting..."
        if [ -f "$PIDFILE" ]; then
          mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
          MPVPID=$!
          echo $MPVPID > "$PIDFILE"
          echo "mpvpaper restarted with PID $MPVPID"
        else
          echo "PIDFILE removed, exiting daemon"
          exit 0
        fi
      fi
      sleep 5
    done
  else
    if [ ! -f "$LAST_WALLPAPER" ]; then
      echo "Error: no wallpaper file found in $LAST_WALLPAPER"
      exit 1
    fi
    
    FILE=$(cat "$LAST_WALLPAPER")
    [ ! -f "$FILE" ] && { echo "Error: wallpaper file not found: $FILE"; exit 1; }
    
    stop_mpvpaper
    echo "Starting wallpaper: $FILE"
    mpvpaper -o "--loop-file --hwdec=nvdec --no-audio" "$DISPLAY" "$FILE" &
    echo $! > "$PIDFILE"
  fi
}

stop_wallpaper() {
  echo "Stopping wallpaper..."
  stop_mpvpaper
  exit 0
}

case "$1" in
  set)
    set_wallpaper
    ;;
  start)
    if [ "$2" = "daemon" ]; then
      start_wallpaper "daemon"
    else
      start_wallpaper
    fi
    ;;
  stop)
    stop_wallpaper
    ;;
  *)
    echo "Usage: $0 {set|start|stop}"
    echo "  set          - select and set wallpaper"
    echo "  start        - start last wallpaper"
    echo "  start daemon - start last wallpaper in daemon mode (for systemd)"
    echo "  stop         - stop wallpaper"
    exit 1
    ;;
esac