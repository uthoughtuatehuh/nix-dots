{ config, pkgs, ... }:

let
  configRasi = ''
    @import "~/.config/rofi/catppuccin.rasi"

    configuration {
      modi: "drun,run,filebrowser,window";
      show-icons: true;
      icon-theme: "Papirus";
      display-drun: "";
      display-run: "";
      display-filebrowser: "";
      display-window: "";
      drun-display-format: "{name}";
      window-format: "{w} · {c} · {t}";
    }

    * {
      font: "JetBrains Mono Nerd Font 10";
      border-colour: var(selected);
      handle-colour: var(selected);
      background-colour: var(background);
      foreground-colour: var(foreground);
      alternate-background: var(background-alt);
    }

    window {
      transparency: "real";
      location: center;
      anchor: center;
      width: 600px;
      border: 2px solid;
      border-radius: 10px;
      border-color: @border-colour;
      background-color: @background-colour;
    }

    mainbox {
      spacing: 10px;
      padding: 25px;
      children: [ "inputbar", "message", "listview" ];
    }

    inputbar {
      spacing: 10px;
      children: [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    textbox-prompt-colon {
      str: "";
    }

    listview {
      columns: 1;
      lines: 8;
      scrollbar: true;
      spacing: 5px;
    }

    element {
      spacing: 10px;
      padding: 5px 10px;
      border-radius: 10px;
    }

    element selected.normal {
      background-color: var(selected-normal-background);
      text-color: var(selected-normal-foreground);
    }
  '';

  powermenuRasi = ''
    @import "~/.config/rofi/catppuccin.rasi"

    * {
      font: "JetBrains Mono Nerd Font 9";
    }

    configuration {
      show-icons: false;
    }

    window {
      transparency: "real";
      width: 600px;
      border: 2px solid;
      border-radius: 10px;
      border-color: @selected;
      background-color: @background;
    }

    mainbox {
      spacing: 15px;
      padding: 25px;
      children: [ "inputbar", "listview" ];
    }

    inputbar {
      spacing: 15px;
      children: [ "textbox-prompt-colon", "prompt"];
    }

    textbox-prompt-colon {
      str: "";
      padding: 6px 14px 6px 10px;
      border-radius: 10px;
      background-color: @urgent;
      text-color: @background;
    }

    prompt {
      padding: 7px 14px;
      border-radius: 10px;
      background-color: @active;
      text-color: @background;
    }

    listview {
      columns: 5;
      lines: 1;
      spacing: 15px;
    }

    element {
      padding: 20px 0;
      border-radius: 10px;
      background-color: @background-alt;
    }

    element selected.normal {
      background-color: var(selected);
      text-color: var(background);
    }
  '';

  catppuccinRasi = ''
    * {
      background:     #1E1D2FFF;
      background-alt: #282839FF;
      foreground:     #D9E0EEFF;
      selected:       #7AA2F7FF;
      active:         #ABE9B3FF;
      urgent:         #F28FADFF;
    }
  '';

  powermenuScript = ''
    #!/usr/bin/env bash
    dir="$HOME/.config/rofi/"
    theme='powermenu'
    uptime="`uptime | sed -e 's/up //g'`"
    shutdown='󰤆'
    reboot='󰜉'
    lock='󰌾'
    suspend='󰏤'
    logout='󰍃'
    yes=''
    no='󰜺'

    rofi_cmd() {
      rofi -dmenu -p "Uptime: $uptime" -mesg "Uptime: $uptime" -theme ${dir}/${theme}.rasi
    }

    confirm_cmd() {
      rofi -theme-str 'window {location: center; anchor: center; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -dmenu -p 'Confirmation' -mesg 'Are you Sure?' -theme ${dir}/${theme}.rasi
    }

    confirm_exit() { echo -e "$yes\n$no" | confirm_cmd; }

    run_rofi() { echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd; }

    run_cmd() {
      selected="$(confirm_exit)"
      if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
          mpc -q pause
          amixer set Master mute
          systemctl suspend
        elif [[ $1 == '--logout' ]]; then hyprctl dispatch exit
        fi
      else exit 0; fi
    }

    chosen="$(run_rofi)"
    case ${chosen} in
      $shutdown) run_cmd --shutdown ;;
      $reboot) run_cmd --reboot ;;
      $lock) hyprlock ;;
      $suspend) run_cmd --suspend ;;
      $logout) run_cmd --logout ;;
    esac
  '';
in {
  xdg.configFile = {
    "rofi/config.rasi".text = configRasi;
    "rofi/powermenu.rasi".text = powermenuRasi;
    "rofi/catppuccin.rasi".text = catppuccinRasi;
    "rofi/powermenu.sh" = {
      text = powermenuScript;
      executable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    rofi
    papirus-icon-theme
  ];
}
