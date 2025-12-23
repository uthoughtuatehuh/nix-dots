{ config, pkgs, lib, ... }:
{
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-pipewire-audio-capture
  ];
}
