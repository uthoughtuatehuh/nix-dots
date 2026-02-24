{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    hyprlock
    mpvpaper
    ydotool
    fuzzel
    zenity
    ffmpeg
    slurp
    grim
    rofi
  ];
}
