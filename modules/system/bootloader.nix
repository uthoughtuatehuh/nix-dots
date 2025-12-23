{ config, pkgs, ... }:
{
  boot = {
    supportedFilesystems = [ "btrfs" ];
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = [
    "tun"
  ];
}
