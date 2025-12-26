{ config, pkgs, inputs, ... }:

let
  systemModules = [
    "virtualization"
    "bootloader"
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
