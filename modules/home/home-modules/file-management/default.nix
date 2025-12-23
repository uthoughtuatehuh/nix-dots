{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    file-roller
    nautilus
    gvfs
  ];
}
