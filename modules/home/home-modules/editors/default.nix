{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    vscodium
    micro
  ];
}
