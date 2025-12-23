{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./default.nix
  ];
  
  system.stateVersion = "25.05";
}
