{ config, pkgs, ... }:
{
  xdg.configFile = {
    # WAYBAR
    "waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
    "waybar/style.css".source = ./configs/waybar/style.css;
        
    # DUNST
    "dunst/dunstrc".source = ./configs/dunst/dunstrc;

    # FISH
    "fish/config.fish".source = ./configs/fish/config.fish;
    "fish/fish_variables".source = ./configs/fish/fish_variables;

    # KITTY
    "kitty/kitty.conf".source = ./configs/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ./configs/kitty/current-theme.conf;

    # ROFI
    "rofi/catppuccin.rasi".source = ./configs/rofi/catppuccin.rasi;
    "rofi/config.rasi".source = ./configs/rofi/config.rasi;
    "rofi/powermenu.rasi".source = ./configs/rofi/powermenu.rasi;
    "rofi/powermenu.sh" = {
      source = ./configs/rofi/powermenu.sh;
      executable = true;
    };

    # HYPRLAND
    "hypr/hypridle.conf".source = ./configs/hypr/hypridle.conf;
    "hypr/hyprland/animations.conf".source = ./configs/hypr/hyprland/animations.conf;
    "hypr/hyprland/decoration.conf".source = ./configs/hypr/hyprland/decoration.conf;
    "hypr/hyprland/env.conf".source = ./configs/hypr/hyprland/env.conf;
    "hypr/hyprland/execs.conf".source = ./configs/hypr/hyprland/execs.conf;
    "hypr/hyprland/general.conf".source = ./configs/hypr/hyprland/general.conf;
    "hypr/hyprland/group.conf".source = ./configs/hypr/hyprland/group.conf;
    "hypr/hyprland/input.conf".source = ./configs/hypr/hyprland/input.conf;
    "hypr/hyprland/keybinds.conf".source = ./configs/hypr/hyprland/keybinds.conf;
    "hypr/hyprland/misc.conf".source = ./configs/hypr/hyprland/misc.conf;
    "hypr/hyprland/rules.conf".source = ./configs/hypr/hyprland/rules.conf;
	"hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
	"hypr/variables.conf".source = ./configs/hypr/variables.conf;
	"hypr/scheme/default.conf".source = ./configs/hypr/scheme/default.conf;
    
    "hypr/scripts/wsaction.fish" = {
      source = ./configs/hypr/scripts/wsaction.fish;
      executable = true;
    };
  };

  home.file.".Xresources".source = ./configs/Xresources;
}
