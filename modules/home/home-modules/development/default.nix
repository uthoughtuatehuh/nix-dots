{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    openjdk17
    nodejs
  ];
}
