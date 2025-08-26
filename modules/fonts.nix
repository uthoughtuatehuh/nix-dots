{ config, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
    ];
    fontconfig.enable = true;
  };
}
