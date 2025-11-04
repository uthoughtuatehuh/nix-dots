{ config, pkgs, inputs, ... }:
{
  imports = [
    ./home/packages.nix
    ./home/desktop.nix

    ./profiles/shared/default.nix
    ./profiles/caelestia/default.nix
    # ./profiles/waybar/default.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";
}
