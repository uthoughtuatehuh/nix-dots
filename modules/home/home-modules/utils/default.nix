{ config, pkgs, inputs, ... }:

let
  utilsModules = [
    "utilities-wayland"
    "utilities-system"
    "file-management"
    "utilities"
  ];
in
{
  imports = map (module: ./${module}.nix) utilsModules;
}
