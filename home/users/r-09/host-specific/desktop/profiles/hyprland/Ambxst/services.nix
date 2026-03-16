{ config, lib, pkgs, ... }:
{
  # systemd.user.services = {
  #   ambxst = {
  #     Unit = {
  #       Description = "Ambxst";
  #       PartOf = [ "graphical-session.target" ];
  #       After = [ "graphical-session.target" ];
  #       StopWhenUnneeded = true;
  #     };
  #     Service = {
  #       Type = "simple";
  #       ExecStart = "ambxst";
  #       # ExecStart = "/home/user/.nix-profile/bin/ambxst";
  #       Restart = "on-failure";
  #       RestartSec = 3;
  #     };
  #     Install.WantedBy = [ "graphical-session.target" ];
  #   };
  # };
}
