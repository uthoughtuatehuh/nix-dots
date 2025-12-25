{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./default.nix
    ../../config.nix
  ];
  
  system.stateVersion = "25.05";
}
