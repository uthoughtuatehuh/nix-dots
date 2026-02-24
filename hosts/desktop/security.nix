{ config, pkgs, lib, user, ... }:
{
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    # checkReversePath = "loose";
    logReversePathDrops = true;
    allowPing = false;
  };

  # Privilege escalation
  security = {
    sudo.enable = false;
    
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ user ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    
    # Kernel hardening
    protectKernelImage = true;
  };


  boot.kernelParams = [
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
