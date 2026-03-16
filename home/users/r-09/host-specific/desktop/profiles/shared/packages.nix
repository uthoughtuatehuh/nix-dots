{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    fish
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];
}
