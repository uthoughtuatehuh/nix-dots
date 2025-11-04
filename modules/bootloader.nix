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
    "luks-9d4e1ff3-9db8-4402-8a04-ba8b3ebb4493" = {
      device = "/dev/disk/by-uuid/9d4e1ff3-9bd8-4402-8a04-ba8b3ebb4493";
      keyFile = "/boot/crypto_keyfile.bin";
    };
    "luks-e7e0f8a8-ab69-4dfc-9efb-1b0f147dea1c" = {
      keyFile = "/boot/crypto_keyfile.bin";
    };
  };

  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };
}
