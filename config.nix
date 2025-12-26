{
  configlib = {
    # NETWORKING
    networking = {
      hostname = "nixos";
      timeZone = {
        region = "Europe";
        location = "Moscow";
      };
      firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };
    };

    # SERVICES
    services = {
      flatpak = {
        enable = true;
      };
    };

    # PROGRAMS
    programs = {
      steam.enable = true;
      honkers-railway-launcher.enable = true;
      sleepy-launcher.enable = true;
    };

    # USERS
    users = {
  	  extraGroups = [ "networkmanager" "wheel" "libvirtd" "wireshark" "keys" "video" ];
    };

    # SECURITY
    security.sudoer = "doas";


    # BOOT
    boot = {
      loader = "lanzaboote";
      kernelModules = [ "tun" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "v4l2loopback" ];
      blacklistedKernelModules = [ ]; # = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nouveau" ];
      supportedFileSystems = [ "btrfs" ];
      kernelParams = [
        "intel_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=10de:1c82,10de:0fb9"
      ];
    };

    # HOME
    
  };
}
