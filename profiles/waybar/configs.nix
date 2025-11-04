{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    # WAYBAR
    "waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
    "waybar/style.css".source = ./configs/waybar/style.css;
          
    # DUNST
    "dunst/dunstrc".source = ./configs/dunst/dunstrc;
  
    # ROFI
    "rofi/catppuccin.rasi".source = ./configs/rofi/catppuccin.rasi;
    "rofi/config.rasi".source = ./configs/rofi/config.rasi;
    "rofi/powermenu.rasi".source = ./configs/rofi/powermenu.rasi;
    "rofi/powermenu.sh" = {
      source = ./configs/rofi/powermenu.sh;
      executable = true;
    };

    # HYPR
    "hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
    "hypr/hyprlock.conf".source = ./configs/hypr/hyprlock.conf;
    "hypr/modules/env.conf".source = ./configs/hypr/modules/env.conf;
    "hypr/modules/execs.conf".source = ./configs/hypr/modules/execs.conf;
    "hypr/modules/general.conf".source = ./configs/hypr/modules/general.conf;
    "hypr/modules/keybinds.conf".source = ./configs/hypr/modules/keybinds.conf;
    "hypr/modules/rules.conf".source = ./configs/hypr/modules/rules.conf;
    "hypr/modules/variables.conf".source = ./configs/hypr/modules/variables.conf;
    "hypr/scripts/switch_wallpaper.sh" = {
      source = ./configs/hypr/scripts/switch_wallpaper.sh;
      executable = true;
    };
    "hypr/scripts/switch_workspace.sh" = {
      source = ./configs/hypr/scripts/switch_workspace.sh;
      executable = true;
    };
  };
}
