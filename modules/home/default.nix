{ config, pkgs, inputs, ... }:

let
  homeModules = [
    "reverse-engineering"
    "utilities-wayland"
    "utilities-system"
    "file-management"
    "virtualization"
    "development"
    "obs-studio"
    "utilities"
    "telegram"
    "obsidian"
    "terminal"
    "nixcord"
    "editors"
    "firefox"
    "themes"
    "gnome"
    "media"
    "wine"
    "vpn"
  ];
in
{
  imports = map (module: ./home-modules/${module}/default.nix) homeModules;
}
