{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "uthoughtuatehuh";
        email = "quanvepluxary@proton.me";
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
}
