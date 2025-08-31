{ config, pkgs, inputs, ... }:
{
  imports = [
    ./home/packages.nix
    ./home/configs.nix
    ./home/desktop.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";
}
