{ config, pkgs, ... }:
{
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
      enable = true;
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
  	  enable = true;
  	  remotePlay.openFirewall = true;
  	  dedicatedServer.openFirewall = true;
  	  localNetworkGameTransfers.openFirewall = true;
  	};
  	
  	honkers-railway-launcher.enable = true;
  	sleepy-launcher.enable = true;
  };
}
