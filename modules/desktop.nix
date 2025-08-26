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
    displayManager.ly.enable = true;
  };

  programs = {
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
  };
}
