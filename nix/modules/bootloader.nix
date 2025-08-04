{ config, pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
    enableCryptodisk = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    "luks-9db7ad92-dc1e-4aa8-bfc6-59422e94f6b4" = {
      device = "/dev/disk/by-uuid/9db7ad92-dc1e-4aa8-bfc6-59422e94f6b4";
      keyFile = "/boot/crypto_keyfile.bin";
    };
    "luks-fc1bd4b8-4fe4-4cf9-a6f0-b735b9cae6ff" = {
      keyFile = "/boot/crypto_keyfile.bin";
    };
  };

  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };
}
