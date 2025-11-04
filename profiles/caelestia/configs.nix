{ config, lib, pkgs, ... }:
{
  xdg.configFile = {  
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
}
