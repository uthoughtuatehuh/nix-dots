{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    gnome-control-center
    gnome-themes-extra
    dconf-editor
    gnome-boxes
    libadwaita
    nwg-look
  ];
}
