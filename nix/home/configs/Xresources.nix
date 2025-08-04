{ config, pkgs, ... }:
{
  home.file.".Xresources".text = ''
    Xcursor.theme: Bibata-Modern-Classic
    Xcursor.size: 24
  '';
}
