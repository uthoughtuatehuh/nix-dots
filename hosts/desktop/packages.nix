{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # System-level dependencies
      # xdg-desktop-portal-hyprland
      # xdg-desktop-portal-wlr
      # xdg-desktop-portal-gtk
      nvidia-vaapi-driver
      # xwayland-satellite
      wayland-protocols
      # gnome-bluetooth
      gnome-keyring
      # btrfs-progs
      libva-utils
      tpm2-tools
      efitools
      libvdpau
      gitFull
      ethtool
      libva
      sbctl
      git
    ];
  };
}
