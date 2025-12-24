{ config, pkgs, inputs, ... }:

let
  systemModules = [
    "virtualization"
    "bootloader"
    "lanzaboote"
    "networking"
    "packages"
    "hardware"
    "security"
    "desktop"
    "users"
    "fonts"
    "nix"
  ];
in
{
  imports = map (module: ./${module}.nix) systemModules;
}
