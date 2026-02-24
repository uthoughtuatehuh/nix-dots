{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # rust-analyzer
    openjdk17
    libgccjit
    # rustfmt
    python3
    # clippy
    nodejs
    rustup
    # rustc
    # cargo
    gcc
  ];
}
