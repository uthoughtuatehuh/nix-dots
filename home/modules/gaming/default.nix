{ config, pkgs, inputs, ... }:

let
  gamingModules = [
    "wine"
  ];
in
{
  imports = map (module: ./${module}.nix) gamingModules;
}
