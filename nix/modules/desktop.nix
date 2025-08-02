{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
