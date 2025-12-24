{ config, pkgs, inputs, ... }:

let
  commsModules = [
    "telegram"
    "obsidian"
    "nixcord"
  ];
in
{
  imports = map (module: ./${module}.nix) commsModules;
}
