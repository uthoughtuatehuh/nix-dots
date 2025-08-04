{ config, pkgs, ... }:
{
  xdg.configFile."hypr/modules/execs.conf".text = ''
    exec-once = waybar
    exec-once = bash ~/.config/hypr/scripts/switch_wallpaper.sh start
    exec-once = xrdb -merge ~/.Xresources
  '';
}
