{ config, pkgs, inputs, ... }:

let
  devModules = [
    "reverse-engineering"
    "virtualization"
    "development"
    "vpn"
  ];
in
{
  imports = map (module: ./${module}.nix) devModules;
}
