{ config, lib, pkgs, ... }:
{
  imports = [
  	./packages.nix
  	./services.nix
  	./desktop.nix
  	./configs.nix
  ];
}
