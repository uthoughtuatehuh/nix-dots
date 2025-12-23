{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    libguestfs-appliance
    bridge-utils
    virt-manager
    virt-viewer
    libguestfs
    qemu_kvm
    dnsmasq
    swtpm
    OVMF
  ];
}
