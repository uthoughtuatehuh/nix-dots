{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # System-level dependencies
      wayland-protocols
      libva
      libvdpau
      gnome-keyring
      gnome-bluetooth
    ];
  };
}
