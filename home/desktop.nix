{ config, pkgs, ... }:
{
  programs = {
  	caelestia = {
  	  enable = true;
  	  cli = {
  	  	enable = true;
  	  };
  	};
  };
}
