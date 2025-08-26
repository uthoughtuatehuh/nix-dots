{ config, pkgs, ... }:
{
  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/ae58d928-cb9f-46a7-84ce-4239e2b575ed";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}
