{
  configlib = {
    disks = {
      primary = {
        device = "/dev/nvme0n1";
        fsType = "btrfs";
        encrypted = true;
        compression = "zstd:3";
        extraSubvolumes = {
          "@nix" = {
            mountpoint = "/nix";
            mountOptions = [ "compress=zstd:3" "noatime" ];
          };
          "@home" = {
            mountpoint = "/home/";
            mountOptions = [ "compress=zstd:3" "noatime" ];
          };
        };
      };
      secondary = {
        enable = false;
      };
    };
    swap = {
      enable = true;
      size = "2G";
    };
  };
}
