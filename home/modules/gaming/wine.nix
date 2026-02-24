{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    winetricks
    protonplus
    heroic
    lutris
    wine
  ];
}
