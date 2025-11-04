{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    "fish/config.fish".source = ./configs/fish/config.fish;
    "fish/fish_variables".source = ./configs/fish/fish_variables;

    "kitty/kitty.conf".source = ./configs/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ./configs/kitty/current-theme.conf;
  };
}
