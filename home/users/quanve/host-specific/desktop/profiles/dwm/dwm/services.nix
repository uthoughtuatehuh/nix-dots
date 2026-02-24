{ config, lib, pkgs, ... }:
{
  systemd.user.services = {
    dwm-autostart = {
      Unit = {
        Description = "DWM Autostart service";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        StopWhenUnneeded = true;
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = [
          "${pkgs.xorg.xinput}/bin/xinput --set-prop 11 \"libinput Accel Profile Enabled\" 0 1"
          "${pkgs.xorg.xinput}/bin/xinput --set-prop 11 \"libinput Accel Speed\" -0.74"
          "${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout us,ru -option grp:alt_shift_toggle"
        ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    dwm-bar = {
      Unit = {
        Description = "DWM Bar service";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        StopWhenUnneeded = true;
      };
      Service = {
        Type = "simple";
        ExecStart = "${config.home.homeDirectory}/.config/dwm/dwm-bar.sh";
        Restart = "on-failure";
        RestartSec = 3;
        Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/user/bin:/usr/bin:/bin";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
