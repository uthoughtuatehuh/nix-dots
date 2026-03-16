{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    "fish/config.fish".source = ./configs/fish/config.fish;
    
    "kitty/kitty.conf".source = ./configs/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ./configs/kitty/current-theme.conf;
  };
}
