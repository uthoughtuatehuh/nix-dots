{ config, pkgs, userConfig, ... }:
{
  users.users.${userConfig.username} = {
    isNormalUser = true;
    description = userConfig.username;
    extraGroups = [ "networkmanager" "wheel" "libvirt" "libvirtd" "wireshark" ];
    packages = with pkgs; [];
  };
}
