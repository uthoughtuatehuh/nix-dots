{ config, lib, pkgs, ... }:
{
  imports = [
    ./services.nix
    ./scripts.nix
  ];
  home.packages = with pkgs; [
    dmenu
    st
  ];
}
