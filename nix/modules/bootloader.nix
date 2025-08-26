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
    "luks-fce9778b-6dac-496a-bcd0-448cc8a1ce1c" = {
      device = "/dev/disk/by-uuid/fce97778b-6dac-496a-bcd0-448cc8a1ce1c";
      keyFile = "/boot/crypto_keyfile.bin";
    };
    "luks-43c9992c-8ddb-4dc8-b493-6e8aad05d8df" = {
      keyFile = "/boot/crypto_keyfile.bin";
    };
  };

  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };
}
