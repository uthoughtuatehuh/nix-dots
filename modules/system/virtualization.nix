{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    swtpm.enable = true;
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
