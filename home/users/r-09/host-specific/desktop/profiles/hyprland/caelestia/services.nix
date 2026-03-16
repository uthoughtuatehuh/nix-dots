{ config, lib, pkgs, ... }:
{
  systemd.user.services = {
    hyprland-delayed-reload = {
      Unit = {
        Description = "Delayed Hyprland reload";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/sleep 3 && ${pkgs.hyprland}/bin/hyprctl reload";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
