{ config, pkgs, lib, ... }:
{
  options.configlib.boot = {
    kernelModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional kernel modules to load at boot";
    };

    kernelParams = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional kernel parameters";
    };

    supportedFileSystems = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    blacklistedKernelModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "lanzaboote" ];
      default = "systemd-boot";
      description = "Boot loader to use";
    };
  };

  config = lib.mkMerge [
    {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = config.configlib.boot.supportedFileSystems;
        kernelModules = config.configlib.boot.kernelModules;
        kernelParams = config.configlib.boot.kernelParams;
        blacklistedKernelModules = config.configlib.boot.blacklistedKernelModules;
        extraModprobeConfig = ''
          options vfio-pci ids=10de:1c82,10de:0fb9
        '';
      };
    }

    (lib.mkIf (config.configlib.boot.loader == "lanzaboote") {
      boot.loader.systemd-boot.enable = lib.mkForce false;
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
      boot.loader.efi.canTouchEfiVariables = true;
    })

    (lib.mkIf (config.configlib.boot.loader == "systemd-boot") {
      boot.loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
      };
    })
  ];
}
