{ config, pkgs, ... }:
{
  xdg.configFile."hypr/modules/variables.conf".text = ''
    $terminal = kitty
    $fileManager = dolphin
    $menu = rofi -show drun
    $mainMod = SUPER
  '';
}
