{ config, lib, pkgs, ... }:
let
  inherit (lib) mkMerge mkIf mkDefault;
in
{
  options.configlib = {
    disks = {
      primary = {
        device = lib.mkOption {
          type = lib.types.str;
          default = "/dev/nvme0n1";
          description = "Main drive device (SSD)";
        };
        fsType = lib.mkOption {
          type = lib.types.enum [ "btrfs" "zfs" "ext4" ];
          default = "btrfs";
          description = "File system for primary";
        };
        encrypted = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Encrypt primary LUKS?";
        };
        compression = lib.mkOption {
          type = lib.types.str;
          default = "zstd:3";
          description = "Compression for subvolumes/datasets (btrfs/zfs only; ‘none’ to disable)";
        };
        extraSubvolumes = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              mountpoint = lib.mkOption {
                type = lib.types.str;
                description = "Mount point for a subvolume/dataset";
              };
              mountOptions = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "Mount options for btrfs";
              };
              properties = lib.mkOption {
                type = lib.types.attrsOf lib.types.anything;
                default = { };
                description = "Properties for ZFS datasets";
              };
            };
          });
          default = { };
          description = "Additional subvolumes/datasets for primary";
        };
        uuid = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "UUID for primary LUKS (if you need to override device)";
        };
        partuuid = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "PARTUUID for primary partition";
        };
      };
      secondary = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable formatting/mounting of secondary disk?";
        };
        device = lib.mkOption {
          type = lib.types.str;
          default = "/dev/sda";
          description = "Secondary disk (HDD) device";
        };
        fsType = lib.mkOption {
          type = lib.types.enum [ "btrfs" "zfs" "ext4" ];
          default = "btrfs";
          description = "File system for secondary";
        };
        encrypted = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Encrypt secondary LUKS?";
        };
        compression = lib.mkOption {
          type = lib.types.str;
          default = "zstd:3";
          description = "Compression for subvolumes/datasets (btrfs/zfs only; ‘none’ to disable)";
        };
        extraSubvolumes = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              mountpoint = lib.mkOption {
                type = lib.types.str;
                description = "Mount point for subvolume/dataset";
              };
              mountOptions = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "Mount options for btrfs";
              };
              properties = lib.mkOption {
                type = lib.types.attrsOf lib.types.anything;
                default = { };
                description = "Properties for ZFS datasets";
              };
            };
          });
          default = { };
          description = "Additional subvolumes/datasets for secondary";
        };
        uuid = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "UUID for secondary LUKS (if you need to override the device)";
        };
        partuuid = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "PARTUUID for secondary partition";
        };
      };
    };
    swap = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable swap?";
      };
      size = lib.mkOption {
        type = lib.types.str;
        default = "16G";
        description = "Swap size (e.g., ‘16G’, ‘32G’)";
      };
    };
  };
  config = let
    cfg = config.configlib;
    getPartitionPrefix = devicePath:
      if lib.strings.hasPrefix "/dev/nvme" devicePath then "p"
      else if lib.strings.hasPrefix "/dev/mmcblk" devicePath then "p"
      else "";
    getPartition = devicePath: partitionNumber:
      "${devicePath}${getPartitionPrefix devicePath}${toString partitionNumber}";
    getLuksDevice = device: uuid: partuuid: defaultPartition:
      if uuid != null then "/dev/disk/by-uuid/${uuid}"
      else if partuuid != null then "/dev/disk/by-partuuid/${partuuid}"
      else defaultPartition;
    primaryDevice = cfg.disks.primary.device;
    secondaryDevice = if cfg.disks.secondary.enable then cfg.disks.secondary.device else null;
    swapPath = if cfg.disks.primary.fsType == "zfs" then "zroot/swap" else "/swap/swapfile";
    primaryEfiPartition = getPartition primaryDevice 1;
    primaryRootPartition = getPartition primaryDevice 2;
   
    secondaryStoragePartition = mkIf cfg.disks.secondary.enable (
      getPartition secondaryDevice 1
    );
    primaryLuksDevice = getLuksDevice primaryDevice
      cfg.disks.primary.uuid
      cfg.disks.primary.partuuid
      primaryRootPartition;
    secondaryLuksDevice = mkIf cfg.disks.secondary.enable (
      getLuksDevice secondaryDevice
        cfg.disks.secondary.uuid
        cfg.disks.secondary.partuuid
        secondaryStoragePartition
    );
    mkBtrfsMountOptions = compression: if compression != "none" then [ "compress=${compression}" "noatime" ] else [ "noatime" ];
    primaryBtrfsSubvols = lib.attrsets.recursiveUpdate {
      "@" = {
        mountpoint = "/";
        mountOptions = mkBtrfsMountOptions cfg.disks.primary.compression;
      };
      "@home" = {
        mountpoint = "/home";
        mountOptions = mkBtrfsMountOptions cfg.disks.primary.compression;
      };
      "@nix" = {
        mountpoint = "/nix";
        mountOptions = mkBtrfsMountOptions cfg.disks.primary.compression;
      };
      "@swap" = mkIf cfg.swap.enable {
        mountpoint = "/swap";
        mountOptions = [ "noatime" ];
      };
    } cfg.disks.primary.extraSubvolumes;
    secondaryBtrfsSubvols = mkIf cfg.disks.secondary.enable (
      lib.attrsets.recursiveUpdate {
        "@games" = {
          mountpoint = "/games";
          mountOptions = if cfg.disks.secondary.compression != "none" then
            [ "compress=${cfg.disks.secondary.compression}" "noatime" "nodatacow" ]
          else
            [ "noatime" "nodatacow" ];
        };
        "@snapshots" = {
          mountpoint = "/mnt/snapshots";
          mountOptions = mkBtrfsMountOptions cfg.disks.secondary.compression;
        };
        "@storage" = {
          mountpoint = "/mnt/storage";
          mountOptions = mkBtrfsMountOptions cfg.disks.secondary.compression;
        };
      } cfg.disks.secondary.extraSubvolumes
    );
    primaryZfsDatasets = let
      comp = if cfg.disks.primary.compression != "none" then { compression = cfg.disks.primary.compression; } else { };
    in lib.attrsets.recursiveUpdate {
      "root" = {
        type = "filesystem";
        mountpoint = "/";
        properties = comp;
      };
      "home" = {
        type = "filesystem";
        mountpoint = "/home";
        properties = comp;
      };
      "nix" = {
        type = "filesystem";
        mountpoint = "/nix";
        properties = comp;
      };
      "swap" = mkIf cfg.swap.enable {
        type = "volume";
        size = cfg.swap.size;
      };
    } cfg.disks.primary.extraSubvolumes;
    secondaryZfsDatasets = mkIf cfg.disks.secondary.enable (
      let
        comp = if cfg.disks.secondary.compression != "none" then { compression = cfg.disks.secondary.compression; } else { };
      in lib.attrsets.recursiveUpdate {
        "games" = {
          type = "filesystem";
          mountpoint = "/games";
          properties = comp;
        };
        "snapshots" = {
          type = "filesystem";
          mountpoint = "/mnt/snapshots";
          properties = comp;
        };
        "storage" = {
          type = "filesystem";
          mountpoint = "/mnt/storage";
          properties = comp;
        };
      } cfg.disks.secondary.extraSubvolumes
    );
    mkFsContent = fsType: label: subvolsOrDatasets: mountpoint: {
      type =
        if fsType == "zfs" then "zpool"
        else if fsType == "btrfs" then "btrfs"
        else "filesystem";
      name = if fsType == "zfs" then label else null;
      format =
        if fsType == "ext4" then "ext4"
        else if fsType == "btrfs" then "btrfs"
        else null;
      extraArgs = if fsType == "btrfs" then [ "-L" label ] else [ ];
      subvolumes = if fsType == "btrfs" then subvolsOrDatasets else { };
      datasets = if fsType == "zfs" then subvolsOrDatasets else { };
      mountpoint = if fsType == "ext4" && mountpoint != null then mountpoint else null;
    };
    mkLuks = content: name: {
      type = "luks";
      format = "luks2";
      name = name;
      settings = { allowDiscards = true; };
      content = content;
    };
  in {
    assertions = [
      {
        assertion = lib.strings.hasPrefix "/dev/" cfg.disks.primary.device;
        message = "Primary device must start with /dev/ (e.g., /dev/nvme0n1)";
      }
      {
        assertion = if cfg.disks.primary.fsType == "ext4" && cfg.disks.primary.extraSubvolumes != { } then false else true;
        message = "extraSubvolumes not supported for ext4 on primary";
      }
      {
        assertion = if cfg.disks.primary.compression != "none" && (cfg.disks.primary.fsType == "ext4") then false else true;
        message = "Compression not supported for ext4 on primary";
      }
      {
        assertion = if cfg.disks.primary.uuid != null then lib.strings.isString cfg.disks.primary.uuid && lib.strings.stringLength cfg.disks.primary.uuid > 0 else true;
        message = "UUID for primary must be a non-empty string if set";
      }
      {
        assertion = if cfg.disks.primary.partuuid != null then lib.strings.isString cfg.disks.primary.partuuid && lib.strings.stringLength cfg.disks.primary.partuuid > 0 else true;
        message = "PARTUUID for primary must be a non-empty string if set";
      }
      {
        assertion = if cfg.disks.secondary.enable then lib.strings.hasPrefix "/dev/" cfg.disks.secondary.device else true;
        message = "Secondary device must start with /dev/ if enabled";
      }
      {
        assertion = if cfg.disks.secondary.enable && cfg.disks.secondary.fsType == "ext4" && cfg.disks.secondary.extraSubvolumes != { } then false else true;
        message = "extraSubvolumes not supported for ext4 on secondary";
      }
      {
        assertion = if cfg.disks.secondary.enable && cfg.disks.secondary.compression != "none" && (cfg.disks.secondary.fsType == "ext4") then false else true;
        message = "Compression not supported for ext4 on secondary";
      }
      {
        assertion = if cfg.disks.secondary.enable && cfg.disks.secondary.uuid != null then lib.strings.isString cfg.disks.secondary.uuid && lib.strings.stringLength cfg.disks.secondary.uuid > 0 else true;
        message = "UUID for secondary must be a non-empty string if set";
      }
      {
        assertion = if cfg.disks.secondary.enable && cfg.disks.secondary.partuuid != null then lib.strings.isString cfg.disks.secondary.partuuid && lib.strings.stringLength cfg.disks.secondary.partuuid > 0 else true;
        message = "PARTUUID for secondary must be a non-empty string if set";
      }
      {
        assertion = if cfg.swap.enable then lib.strings.match "[0-9]+[GMK]" cfg.swap.size != null else true;
        message = "Swap size must be like '16G', '32M', etc.";
      }
    ];
    disko = {
      enableConfig = true;
      mode = "disko";
      devices = {
        disk = lib.mkMerge [
          {
            "${builtins.baseNameOf primaryDevice}" = {
              type = "disk";
              device = primaryDevice;
              format = "gpt";
              partitions = if cfg.disks.primary.fsType == "ext4" then {
                esp = {
                  type = "EF00";
                  size = "512M";
                  format = "vfat";
                  name = "EFI";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "defaults" ];
                  };
                };
                root = {
                  size = "100%";
                  content = if cfg.disks.primary.encrypted then
                    mkLuks (mkFsContent "ext4" "nixos" { } "/") "luks-ssd"
                  else
                    mkFsContent "ext4" "nixos" { } "/";
                };
              } else {
                esp = {
                  type = "EF00";
                  size = "512M";
                  format = "vfat";
                  name = "EFI";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "defaults" ];
                  };
                };
                root = {
                  size = "100%";
                  content = let
                    content = mkFsContent cfg.disks.primary.fsType "nixos"
                      (if cfg.disks.primary.fsType == "btrfs" then primaryBtrfsSubvols
                      else if cfg.disks.primary.fsType == "zfs" then primaryZfsDatasets
                      else { })
                      null;
                  in if cfg.disks.primary.encrypted then
                    mkLuks content "luks-ssd"
                  else
                    content;
                };
              };
            };
          }
          (mkIf cfg.disks.secondary.enable {
            "${builtins.baseNameOf secondaryDevice}" = {
              type = "disk";
              device = secondaryDevice;
              format = "gpt";
              partitions = if cfg.disks.secondary.fsType == "ext4" then {
                storage = {
                  size = "100%";
                  content = let
                    content = mkFsContent "ext4" "storage" { } "/mnt/storage";
                  in if cfg.disks.secondary.encrypted then
                    mkLuks content "luks-hdd"
                  else
                    content;
                };
              } else {
                storage = {
                  size = "100%";
                  content = let
                    content = mkFsContent cfg.disks.secondary.fsType "storage"
                      (if cfg.disks.secondary.fsType == "btrfs" then secondaryBtrfsSubvols
                      else if cfg.disks.secondary.fsType == "zfs" then secondaryZfsDatasets
                      else { })
                      null;
                  in if cfg.disks.secondary.encrypted then
                    mkLuks content "luks-hdd"
                  else
                    content;
                };
              };
            };
          })
        ];
        nodev = mkIf (cfg.swap.enable && cfg.disks.primary.fsType != "zfs") {
          "${swapPath}" = {
            type = "swap";
            size = cfg.swap.size;
            options = [ "noatime" ];
          };
        };
      };
    };
    boot = {
      supportedFilesystems = mkMerge [
        (mkIf (cfg.disks.primary.fsType == "zfs" || (cfg.disks.secondary.enable && cfg.disks.secondary.fsType == "zfs")) [ "zfs" ])
        (mkIf (cfg.disks.primary.fsType == "btrfs" || (cfg.disks.secondary.enable && cfg.disks.secondary.fsType == "btrfs")) [ "btrfs" ])
      ];
      initrd.luks.devices = mkMerge [
        (mkIf cfg.disks.primary.encrypted {
          "luks-ssd" = {
            device = primaryLuksDevice;
            allowDiscards = true;
          };
        })
        (mkIf (cfg.disks.secondary.enable && cfg.disks.secondary.encrypted) {
          "luks-hdd" = {
            device = secondaryLuksDevice;
            allowDiscards = true;
          };
        })
      ];
    };
    services.zfs = mkIf (cfg.disks.primary.fsType == "zfs" || (cfg.disks.secondary.enable && cfg.disks.secondary.fsType == "zfs")) {
      autoScrub.enable = true;
      trim.enable = true;
    };
    fileSystems = mkMerge [
      (mkIf (cfg.disks.primary.fsType == "ext4") {
        "/" = {
          device = if cfg.disks.primary.encrypted then "/dev/mapper/luks-ssd" else primaryRootPartition;
          fsType = "ext4";
        };
      })
      (mkIf (cfg.disks.secondary.enable && cfg.disks.secondary.fsType == "ext4") {
        "/mnt/storage" = {
          device = if cfg.disks.secondary.encrypted then "/dev/mapper/luks-hdd" else secondaryStoragePartition;
          fsType = "ext4";
        };
      })
    ];
    swapDevices = mkIf (cfg.swap.enable && cfg.disks.primary.fsType == "ext4") [
      { device = "/swap/swapfile"; size = lib.strings.toInt (lib.strings.removeSuffix "G" cfg.swap.size) * 1024; }
    ];
  };
}
