{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # imhex
    binutils
    radare2
    strace
    ltrace
    ghidra
    cutter
    rizin
    lurk
    file
    gdb
  ];
}
