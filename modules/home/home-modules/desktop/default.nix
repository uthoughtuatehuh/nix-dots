{ config, pkgs, inputs, ... }:

let
  desktopModules = [
    "obs-studido"
    "firefox"
    "themes"
    "media"
  ];
in
{
  imports = map (module: ./${module}.nix) desktopModules;
}
