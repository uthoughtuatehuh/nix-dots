{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    waybar
    dunst
  ];
}
