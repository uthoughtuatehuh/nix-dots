{ config, lib, pkgs, ... }:
{
  imports = [
    ./packages.nix
  	./configs.nix
  ];
}
