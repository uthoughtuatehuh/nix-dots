{ config, pkgs, lib, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    swtpm.enable = true;
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  environment.systemPackages = with pkgs; [
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

  virtualisation.spiceUSBRedirection.enable = true;
}
