{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # openssl_legacy
    # cpulimit
    # usbutils
    # pamixer
    # parted
    # cmake
    # unzip
    # aria2
    # ncdu
    # nmap
    # wget
    btop
    # tree
    # htop
    # dig
    # jq
    # fd
  ];
}
