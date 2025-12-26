{ config, pkgs, lib, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    swtpm.enable = true;  # Оставляем для эмуляции TPM (полезно для Windows 11 и passthrough)
    # УДАЛИТЬ эти строки:
    # ovmf.enable = true;
    # ovmf.packages = [ pkgs.OVMFFull.fd ];
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
    OVMF  # Можно оставить для ручного доступа, но не обязательно
  ];

  virtualisation.spiceUSBRedirection.enable = true;
}
