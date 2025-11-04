{ config, pkgs, ... }:
{
  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/dae27629-fcd7-4895-8b94-bd03667d38bd";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}
