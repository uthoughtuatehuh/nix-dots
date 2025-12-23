{ config, pkgs, lib, ... }:
{
  imports = [
  	./plugins.nix
  ];
  
  programs.obs-studio = {
    enable = true;
    package = (pkgs.obs-studio.override {
      cudaSupport = true;
    });
  };
}
