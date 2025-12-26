{ config, pkgs, inputs, ... }:

let
  devModules = [
    "reverse-engineering"
    "development"
    "vpn"
  ];
in
{
  imports = map (module: ./${module}.nix) devModules;
}
