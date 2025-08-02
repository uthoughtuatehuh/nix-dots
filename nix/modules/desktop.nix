{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
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
  	the-honkers-railway-launcher.enable = true;
  };
}
