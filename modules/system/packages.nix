{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # System-level dependencies
      nvidia-vaapi-driver
      wayland-protocols
      gnome-bluetooth
      gnome-keyring
      btrfs-progs
      libva-utils
      efitools
      libvdpau
      polkit
      libva
      sbctl
    ];
  };
}
