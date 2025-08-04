{ config, pkgs, ... }:
{
  imports = [
    # DUNST
    ./configs/dunst/dunstrc.nix

    # KITTY
    ./configs/kitty/kitty.conf.nix
    ./configs/kitty/current-theme.conf.nix

    # HYPR
    ./configs/hypr/hyprland.conf.nix
    ./configs/hypr/hyprlock.conf.nix
    ./configs/hypr/modules/env.conf.nix
    ./configs/hypr/modules/execs.conf.nix
    ./configs/hypr/modules/general.conf.nix
    ./configs/hypr/modules/keybinds.conf.nix
    ./configs/hypr/modules/rules.conf.nix
    ./configs/hypr/modules/variables.conf.nix
    ./configs/hypr/scripts/switch_wallpaper.sh.nix
    ./configs/hypr/scripts/switch_workspace.sh.nix

    # FISH
    ./configs/fish/config.fish.nix
    ./configs/fish/fish_variables.nix

    # ROFI
    ./configs/rofi/catppuccin.rasi.nix
    ./configs/rofi/config.rasi.nix
    ./configs/rofi/powermenu.rasi.nix
    ./configs/rofi/powermenu.sh.nix
  ];
}
