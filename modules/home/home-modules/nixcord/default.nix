{ config, pkgs, lib, ... }:
{
  imports = [
  	./config/plugins.nix
  ];
  
  programs.nixcord = {
    enable = true;
    discord.enable = true;
    vesktop.enable = true;
  };
}
