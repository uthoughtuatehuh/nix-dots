{ config, pkgs, lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    kernelModules = [ "tun" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "v4l2loopback" ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:1c82,10de:0fb9"
      "pcie_aspm=off"
    ];
    blacklistedKernelModules = [ ]; # = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nouveau" ];
    extraModprobeConfig = ''
      options vfio-pci ids=10de:1c82,10de:0fb9

      options r8169 use_dac=0
      options r8169 aspm=0
      options r8169 msi=0
    '';
  };

  boot.loader = {
    systemd-boot = {
      enable = false;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
