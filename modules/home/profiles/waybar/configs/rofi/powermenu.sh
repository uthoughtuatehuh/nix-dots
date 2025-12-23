
#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
## Modified by Nicholas Oliver Bahary
## on 22 September 2024

uptime="`uptime | sed -e 's/up //g'`"
host=`hostname`

shutdown='󰤆'
reboot='󰜉'
lock='󰌾'
suspend='󰏤'
logout='󰍃'

rofi_cmd() {
  rofi -dmenu \
    -p "Uptime: $uptime" \
    -mesg "Uptime: $uptime" \
    -theme $HOME/.config/rofi/powermenu.rasi
}

run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

chosen="$(run_rofi | tr -d '\n\r')"
case $chosen in
  "$shutdown")
    echo "Executing shutdown" >> $LOGFILE
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$lock")
    hyprlock
    ;;
  "$suspend")
    mpc -q pause
    amixer set Master mute
    systemctl suspend
    ;;
  "$logout")
    hyprctl dispatch exit
    ;;
  *)
    exit 1
    ;;
esac