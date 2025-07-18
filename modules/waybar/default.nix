{ config, pkgs, ... }:

let
  styleCss = ''
    #waybar.top {
      background: none;
    }
    #waybar.top > box.horizontal {
      background: #11111b;
      box-shadow: 0 0 4pt #11111b;
      border-radius: 12pt;
      margin: 6pt;
      padding: 2pt;
    }

    #custom-rofi {
      margin-left: 7pt;
      padding-right: 3pt;
      font-size: 12pt;
    }

    #workspaces {
      margin-left: 12pt;
    }
    #workspaces button {
      color: #585b70;
    }
    #workspaces button:not(:first-child) {
      margin-left: 2pt;
    }
    #workspaces button.visible {
      color: #89b4fa;
    }
    #workspaces button.active {
      color: #f38ba8;
    }
    #workspaces button:hover, #workspaces button:focus {
      background: none;
      border-color: transparent;
      box-shadow: none;
    }
    #workspaces button:hover:not(.active):not(.visible), #workspaces button:focus:not(.active):not(.visible) {
      color: #9399b2;
    }

    #mpris {
      background: #1e1e2e;
      color: #a6e3a1;
      border-radius: 12pt;
      margin-left: 15pt;
      padding: 0 8pt;
    }

    #window {
      margin-left: 15pt;
      margin-right: 20pt;
    }

    #memory {
      color: #fab387;
      margin-right: 12pt;
    }

    #tray {
      margin-right: 10pt;
    }
    #tray menu {
      background: #1e1e2e;
      padding: 2pt;
    }
    #tray menu * {
      margin: 2pt;
    }
    #tray menu check {
      margin-right: 4pt;
    }

    @keyframes blink {
      to {
        background-color: rgba(30, 34, 42, 0.5);
        color: #cdd6f4;
      }
    }
    #backlight {
      color: #cba6f7;
      margin-right: 10pt;
    }

    #pulseaudio {
      color: #74c7ec;
      margin-right: 10pt;
    }

    #battery {
      color: #f9e2af;
      margin-right: 15pt;
    }

    #battery.full,
    #battery.good,
    #battery.charging,
    #battery.plugged {
      color: #a6e3a1;
    }

    #battery.critical:not(.charging) {
      color: #f38ba8;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #custom-color-picker {
      margin-right: 18pt;
      font-size: 9pt;
    }

    #custom-screenshot {
      margin-right: 18pt;
      font-size: 10pt;
    }

    #custom-wallpaper {
      margin-right: 16pt;
      font-size: 12pt;
    }

    #custom-power {
      margin-right: 11pt;
      font-size: 10pt;
    }

    #waybar.bottom {
      background: none;
    }
    #waybar.bottom box.modules-center {
      background: #181825;
      margin-top: 5pt;
      padding: 0 4pt;
      border-top-left-radius: 10pt;
      border-top-right-radius: 10pt;
      box-shadow: 0 0 3pt #181825;
    }

    * {
      margin: 0;
      padding: 0;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 8.5pt;
      font-weight: 800;
      transition-property: background;
      transition-duration: 0.5s;
    }

    tooltip {
      background: #11111b;
      color: #cdd6f4;
      border-radius: 5pt;
    }
  '';

  affinityPhotoScript = ''
    #!/usr/bin/bash
    notify-send "Affinity Photo 2" "Photo launched. Please wait." -i "/home/nicholas/.config/waybar/icons/affinity-photo.svg"
    WINE_PREFIX=/home/nicholas/.AffinityLinux
    WINE=/home/nicholas/.AffinityLinux/ElementalWarriorWine/bin/wine
    export WINEPREFIX="$WINE_PREFIX" 
    $WINE "/home/nicholas/.AffinityLinux/drive_c/Program Files/Affinity/Photo 2/Photo.exe"
  '';

  adobePhotoshopScript = ''
    #!/usr/bin/env bash
    notify-send "Adobe Photoshop CC" "Photoshop launched. Please wait." -i "/home/nicholas/.config/waybar/icons/adobe-photoshop.svg"
    SCR_PATH="/home/nicholas/.photoshopCCV19"
    CACHE_PATH="/home/nicholas/.cache/photoshopCCV19"
    export WINEPREFIX="$SCR_PATH/prefix"
    wine64 "$SCR_PATH/prefix/drive_c/users/$USER/PhotoshopSE/Photoshop.exe"
  '';

  reloadScript = ''
    #!/usr/bin/env sh
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    sass ~/.config/waybar/styles/index.scss ~/.config/waybar/style.css
    waybar
  '';

  affinityDesignerScript = ''
    #!/usr/bin/bash
    notify-send "Affinity Designer 2" "Designer launched. Please wait." -i "/home/nicholas/.config/waybar/icons/affinity-designer.svg"
    WINE_PREFIX=/home/nicholas/.AffinityLinux
    WINE=/home/nicholas/.AffinityLinux/ElementalWarriorWine/bin/wine
    export WINEPREFIX="$WINE_PREFIX" 
    $WINE "/home/nicholas/.AffinityLinux/drive_c/Program Files/Affinity/Designer 2/Designer.exe"
  '';

  affinityPublisherScript = ''
    #!/usr/bin/bash
    notify-send "Affinity Publisher 2" "Publisher launched. Please wait." -i "/home/nicholas/.config/waybar/icons/affinity-publisher.svg"
    WINE_PREFIX=/home/nicholas/.AffinityLinux
    WINE=/home/nicholas/.AffinityLinux/ElementalWarriorWine/bin/wine
    export WINEPREFIX="$WINE_PREFIX" 
    $WINE "/home/nicholas/.AffinityLinux/drive_c/Program Files/Affinity/Publisher 2/Publisher.exe"
  '';
in {
  xdg.configFile = {
    "waybar/style.css".text = styleCss;
    
    "waybar/scripts/affinity_photo.sh" = {
      text = affinityPhotoScript;
      executable = true;
    };
    
    "waybar/scripts/adobe_photoshop.sh" = {
      text = adobePhotoshopScript;
      executable = true;
    };
    
    "waybar/scripts/reload.sh" = {
      text = reloadScript;
      executable = true;
    };
    
    "waybar/scripts/affinity_designer.sh" = {
      text = affinityDesignerScript;
      executable = true;
    };
    
    "waybar/scripts/affinity_publisher.sh" = {
      text = affinityPublisherScript;
      executable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    waybar
    sass
  ];
}
