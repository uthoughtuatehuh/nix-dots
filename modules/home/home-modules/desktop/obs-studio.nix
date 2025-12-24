{ config, pkgs, lib, ... }:
{
  obs-studio = {
    enable = true;
    package = (pkgs.obs-studio.override {
      cudaSupport = true;
    });
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      # Добавьте другие плагины, если нужны, например:
      # wlrobs
      # obs-backgroundremoval
      # obs-vaapi
    ];
  };
}
