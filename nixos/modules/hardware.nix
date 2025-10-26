{ config, pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-loader
        libglvnd
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        libglvnd
      ];
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        
      ];
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
  '';

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
