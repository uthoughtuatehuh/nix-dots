{ config, pkgs, lib, ... }:
{
  options.configlib = {
    services = {
      flatpak = {
        enable = lib.mkOption {
          type = lib.types.true;
        };
      };
    };
    programs = {
      steam.enable = lib.mkOption {
        type = lib.types.bool;
      };
      honkers-railway-launcher.enable = lib.mkOption {
        type = lib.types.bool;
      };
      sleepy-launcher.enable = lib.mkOption {
        type = lib.types.bool;
      };
    };
  };
  
  config = {
    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "nvidia" ];
        xkb = {
          layout = "us";
          variant = "";
        };
        displayManager.lightdm.enable = false;
      };
    
      flatpak = {
        enable = config.configlib.services.flatpak.enable;
      };

      gnome = {
        gnome-keyring.enable = true;
        gcr-ssh-agent.enable = true;
      };
    
      displayManager.ly.enable = true;
      gvfs.enable = true;
    };

    programs = {
      firejail.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
  	    
      steam = {
        enable = config.configlib.programs.steam.enable;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
  	
      honkers-railway-launcher.enable = config.configlib.programs.honkers-railway-launcher.enable;
      sleepy-launcher.enable = config.configlib.programs.sleepy-launcher.enable;
    };
  };
}
