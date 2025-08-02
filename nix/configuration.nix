{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/bootloader.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/virtualization.nix
    ./modules/filesystems.nix
  ];

  # Nix package manager settings
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # System version
  system.stateVersion = "25.05";
}
