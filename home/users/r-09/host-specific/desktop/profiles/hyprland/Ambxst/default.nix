{ config, lib, pkgs, ... }:
{
  imports = [
  	./packages.nix
  	./services.nix
  	./configs.nix
  ];
}
