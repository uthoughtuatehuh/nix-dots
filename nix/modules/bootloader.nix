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
    "luks-44c2cc59-077f-42a7-8fb4-6fce96c566f2" = {
      device = "/dev/disk/by-uuid/44c2cc59-077f-42a7-8fb4-6fce96c566f2";
      keyFile = "/boot/crypto_keyfile.bin";
    };
    "luks-d8ca3645-83c9-402b-aef5-1b53f7947052" = {
      keyFile = "/boot/crypto_keyfile.bin";
    };
  };

  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };
}
