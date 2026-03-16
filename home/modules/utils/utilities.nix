{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # qbittorrent
    # libreoffice
    # wireshark
    # libnotify
    fastfetch
    # testdisk
  ];
}
