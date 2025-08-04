{ config, pkgs, ... }:
{
  xdg.configFile."waybar/icons/davinci-resolve.png".source = ./davinci-resolve.png;
}
