{ config, pkgs, lib, userConfig, ... }:
{
  options.configlib = {
    users = lib.mkOption {
      default = {};
      type = lib.types.submodule {
        options = {
          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Extra groups for the user";
          };
        };
      };
    };
  };
  
  config = {
    users.users.${userConfig.username} = {
      isNormalUser = true;
      description = userConfig.username;
      extraGroups = config.configlib.users.extraGroups;
      packages = with pkgs; [];
      linger = true;
    };
  };
}
