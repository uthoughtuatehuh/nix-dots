{ config, pkgs, lib, user, ... }:
{
  # Firewall
  networking.firewall = {
    enable = lib.mkDefault true;
    allowedTCPPorts = lib.mkDefault [ ];
    allowedUDPPorts = lib.mkDefault [ ];
    checkReversePath = lib.mkDefault "loose";
    logReversePathDrops = lib.mkDefault true;
    allowPing = lib.mkDefault false;
  };

  # Privilege escalation
  security = {
    sudo.enable = lib.mkDefault false;
    
    doas = {
      enable = lib.mkDefault true;
      extraRules = [
        {
          users = lib.mkDefault [ user ];
          keepEnv = lib.mkDefault true;
          persist = lib.mkDefault true;
        }
      ];
    };
    
    # Kernel hardening
    protectKernelImage = lib.mkDefault true;
  };


  boot.kernelParams = lib.mkDefault [
    "slab_nomerge"
    "init_on_alloc=1"
    "init_on_free=1"
    "page_alloc.shuffle=1"
    "nowatchdog"
    "nmi_watchdog=0"
    "softlockup_panic=0"
    "pti=on"
    "vsmap=full"
    "debugfs=off"
  ];
}
