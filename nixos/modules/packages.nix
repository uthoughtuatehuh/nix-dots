{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # System-level dependencies
      cudaPackages.cudatoolkit
      cudaPackages.cuda_nvcc
      nvidia-vaapi-driver
      cudaPackages.cudnn
      wayland-protocols
      gnome-bluetooth
      gnome-keyring
      libva-utils
      libvdpau
      polkit
      libva
    ];
  };
}
