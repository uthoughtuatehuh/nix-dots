{ config, pkgs, userConfig, ... }:
{
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = [ userConfig.username ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
    
    # Meltdown/Spectre
    protectKernelImage = true;
  };
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; 
    allowedUDPPorts = [ ];
    checkReversePath = "loose";
    logReversePathDrops = true;
  };
  
  boot.kernelParams = [
    "slab_nomerge"
    "init_on_alloc=1"
    "init_on_free=1"
    "page_alloc.shuffle=1"
    "nowatchdog"
    "nmi_watchdog=0"
    "softlockup_panic=0"
  ];
}
