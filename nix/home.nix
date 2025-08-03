{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    htop
  ];
}
