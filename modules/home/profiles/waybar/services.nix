{ config, lib, pkgs, ... }:
{
  systemd.user.services = {
    waybar = {
      Unit = {
        Description = "Waybar status bar";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        StopWhenUnneeded = true;
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  
    dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        StopWhenUnneeded = true;
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        ExecStop = "${pkgs.procps}/bin/pkill -f .dunst-wrapped";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  
    wallpaper-service = {
      Unit = {
        Description = "Wallpaper service";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        StopWhenUnneeded = true;
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${config.home.homeDirectory}/.config/hypr/scripts/switch_wallpaper.sh start";
        ExecStop = "${pkgs.procps}/bin/pkill -f .mpvpaper-wrap";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
