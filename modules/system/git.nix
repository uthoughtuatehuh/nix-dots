{ config, pkgs, lib, ... }:
{
  options.configlib.programs.git.user = lib.mkOption {
    default = {};
    type = lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Git user name";
        };
        email = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Git user email";
        };
      };
    };
    description = "Git user configuration";
  };
  
  config = {
    programs.git = {
      enable = true;

      config = {
        user = {
          name = config.configlib.programs.git.user.name;
          email = config.configlib.programs.git.user.email;
        };

        # init = {
        #   defaultBranch = "main";
        # };
        # pull = {
        #   rebase = true;
        # };
        # push = {
        #   autoSetupRemote = true;
        # };
      };
    };
  };
}
