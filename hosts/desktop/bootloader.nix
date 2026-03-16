{ config, pkgs, lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    kernelModules = [ "tun" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "v4l2loopback" "tpm_tis" ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      # "vfio-pci.ids=10de:1c82,10de:0fb9"
      # "pcie_aspm=off"
      "resume_offset=533760"
      "8250.nr_uarts=0"
      
      "quiet"
      "udev.log_level=3"
      "splash"

      "randomize_kstack_offset=on"
      "spec_store_bypass_disable=on"
      "tsx=off"
      "vsyscall=none"
    ];
    blacklistedKernelModules = [
      "bluetooth" "btusb"
      "thunderbolt"
      "uvcvideo"
    ]; # = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nouveau" ];
    # extraModprobeConfig = ''
    #   options vfio-pci ids=10de:1c82,10de:0fb9
    # '';

    consoleLogLevel = 0;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    loader = {
      systemd-boot = {
        enable = false;
      };
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "breeze";
    };

    initrd.systemd.enable = true;
  };
}
