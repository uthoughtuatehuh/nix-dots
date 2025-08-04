{ config, pkgs, ... }:
{
  xdg.configFile."hypr/modules/env.conf".text = ''
    env = XCURSOR_THEME, Bibata-Modern-Classic
    env = HYPRCURSOR_SIZE,24
  '';
}
