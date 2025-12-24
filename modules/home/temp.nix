{ config, pkgs, ... }:
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/\${builtins.toString config.home.uid}/gcr/ssh";
  };
}
