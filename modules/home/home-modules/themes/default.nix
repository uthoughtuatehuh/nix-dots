{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    bibata-cursors
    adw-gtk3
  ];
}
