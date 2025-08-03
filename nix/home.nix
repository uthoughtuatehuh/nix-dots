{ config, pkgs, ... }:
{
  imports = [
    ./home/packages.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";
}
