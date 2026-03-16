{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    # DWM BAR
    "dwm/dwm-bar.sh" = {
      source = ./scripts/dwm-bar.sh;
      executable = true;
    };
  };
}
