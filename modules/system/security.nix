{ config, pkgs, lib, userConfig, ... }:

{
  options.configlib = {
    networking.firewall = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the firewall";
      };

      allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "List of allowed TCP ports";
      };

      allowedUDPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "List of allowed UDP ports";
      };
    };

    security.sudoer = lib.mkOption {
      type = lib.types.enum [ "sudo" "doas" ];
      default = "doas";
      description = "Which privilege escalation tool to use: sudo or doas";
    };
  };

  config = let
    cfg = config.configlib;
    isDoas = cfg.security.sudoer == "doas";
    isSudo = cfg.security.sudoer == "sudo";
  in {
    # Firewall
    networking.firewall = {
      enable = cfg.networking.firewall.enable;
      allowedTCPPorts = cfg.networking.firewall.allowedTCPPorts;
      allowedUDPPorts = cfg.networking.firewall.allowedUDPPorts;
      checkReversePath = "loose";
      logReversePathDrops = true;
    };

    # Privilege escalation
    security.sudo.enable = isSudo;
    security.doas.enable = isDoas;

    security.doas.extraRules = lib.mkIf isDoas [
      {
        users = [ userConfig.username ];
        keepEnv = true;
        persist = true;
      }
    ];

    # Kernel hardening
    security.protectKernelImage = true;

    boot.kernelParams = [
      "slab_nomerge"
      "init_on_alloc=1"
      "init_on_free=1"
      "page_alloc.shuffle=1"
      "nowatchdog"
      "nmi_watchdog=0"
      "softlockup_panic=0"
    ];
  };
}
