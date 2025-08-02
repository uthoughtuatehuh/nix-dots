{ config, pkgs, ... }:
{
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = [ "user" ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];
    packages = with pkgs; [];
  };
}
