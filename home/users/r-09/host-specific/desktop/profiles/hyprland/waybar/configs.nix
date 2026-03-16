{ config, lib, pkgs, libx, ... }:
{
  xdg.configFile = libx.configBuilder.make {
    waybar = ./configs/waybar;
    dunst = ./configs/dunst;

    rofi = {
      path = ./configs/rofi;
      executable = [
        "powermenu.sh"
      ];
    };

    hypr = {
      path = ./configs/hypr;
      executable = [
        "scripts/switch_wallpaper.sh"
        "scripts/switch_workspace.sh"
      ];
    };
  };
}
