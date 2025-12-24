{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    winetricks
    lutris
    wine
  ];
}
