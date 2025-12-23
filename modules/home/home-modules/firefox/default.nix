{ config, pkgs, lib, ... }:
{
  imports = [
  	./extensions.nix
  ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };
}
