{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    htop
    neofetch
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      g = "git";
    };
    shellInit = ''
      set -x PATH $HOME/.local/bin $PATH
    '';
  };

  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
  };

  home.file = {
    ".config/hypr/hyprland.conf".text = ''
      ##########################
      # uthoughtuatehuh config #
      #      discord@0x24      #
      ##########################

      source = ~/.config/hypr/modules/variables.conf
      source = ~/.config/hypr/modules/keybinds.conf
      source = ~/.config/hypr/modules/env.conf
      source = ~/.config/hypr/modules/general.conf
      source = ~/.config/hypr/modules/execs.conf
      source = ~/.config/hypr/modules/rules.conf
    '';

    ".config/hypr/modules/variables.conf".text = ''
      $terminal = kitty
      $fileManager = dolphin
      $menu = rofi -show drun
      $mainMod = SUPER
    '';

    ".config/hypr/modules/execs.conf".text = ''
      exec-once = waybar
      exec-once = hyprpaper
    '';

    ".config/hypr/modules/keybinds.conf".text = ''
      # See https://wiki.hyprland.org/Configuring/Keywords/
      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, C, killactive,
      bind = $mainMod, DELETE, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, SPACE, togglefloating,
      bind = $mainMod, D, exec, $menu
      bind = $mainMod SHIFT, F, exec, firefox
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      bind = $mainMod, mouse_down, workspace, r-1
      bind = $mainMod, mouse_up, workspace, r+1
      bind = $mainMod SHIFT, mouse_down, movetoworkspace, r-1
      bind = $mainMod SHIFT, mouse_up, movetoworkspace, r+1
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bind = $mainMod, E, exec, nautilus --new-window
      bind = CTRL ALT, DELETE, exec, ~/.config/rofi/powermenu.sh
      bind = $mainMod, L, exec, hyprlock
      bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | tee /tmp/screenshot.png | wl-copy && [ -s /tmp/screenshot.png ] && notify-send -t 600 -i /tmp/screenshot.png "Screenshot" "Screenshot saved and copied to clipboard"
      bind = $mainMod SHIFT, D, fullscreen, 1
      bind = $mainMod, F, fullscreen, 0
      bindl = Ctrl+Shift+Alt, V, exec, sleep 0.5s && ydotool type -d 1 "$(cliphist list | head -1 | cliphist decode)"
    '';

    ".config/hypr/modules/env.conf".text = ''
      env = XCURSOR_THEME, Bibata-Modern-Classic
      env = HYPRCURSOR_SIZE,24
    '';

    ".config/hypr/modules/general.conf".text = ''
      monitor=,preferred,auto,auto

      input {
          kb_layout = us,ru
          kb_options = grp:alt_shift_toggle
          numlock_by_default = true
          repeat_delay = 250
          repeat_rate = 35
          accel_profile = flat
          sensitivity = -0.74
          special_fallthrough = true
          follow_mouse = 1
      }

      general {
          gaps_in = 5
          gaps_out = 15,17
          border_size = 4
          col.active_border = rgba(7899faff)
          col.inactive_border = rgba(1f222bff)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
      }

      decoration {
          rounding = 10
          rounding_power = 2
          active_opacity = 1.0
          inactive_opacity = 1.0
          shadow {
              enabled = true
              ignore_window = true
              range = 25
              offset = 0 2
              render_power = 4
              color = rgba(18192688)
          }
          blur {
              enabled = true
              xray = true
              special = false
              new_optimizations = true
              size = 4
              passes = 1
              brightness = 1
              noise = 0.01
              contrast = 1
              popups = true
              popups_ignorealpha = 0.6
          }
      }

      animations {
          enabled = true
          bezier = linear, 0, 0, 1, 1
          bezier = md3_standard, 0.2, 0, 0, 1
          bezier = md3_decel, 0.05, 0.7, 0.1, 1
          bezier = md3_accel, 0.3, 0, 0.8, 0.15
          bezier = overshot, 0.05, 0.9, 0.1, 1.1
          bezier = crazyshot, 0.1, 1.5, 0.76, 0.92 
          bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
          bezier = menu_decel, 0.1, 1, 0, 1
          bezier = menu_accel, 0.38, 0.04, 1, 0.07
          bezier = easeInOutCirc, 0.85, 0, 0.15, 1
          bezier = easeOutCirc, 0, 0.55, 0.45, 1
          bezier = easeOutExpo, 0.16, 1, 0.3, 1
          bezier = softAcDecel, 0.26, 0.26, 0.15, 1
          bezier = md2, 0.4, 0, 0.2, 1
          animation = windows, 1, 3, md3_decel, popin 60%
          animation = windowsIn, 1, 3, md3_decel, popin 60%
          animation = windowsOut, 1, 3, md3_accel, popin 60%
          animation = border, 1, 10, default
          animation = fade, 1, 3, md3_decel
          animation = layersIn, 1, 3, menu_decel, slide
          animation = layersOut, 1, 1.6, menu_accel
          animation = fadeLayersIn, 1, 2, menu_decel
          animation = fadeLayersOut, 1, 4.5, menu_accel
          animation = workspaces, 1, 7, menu_decel, slide
          animation = specialWorkspace, 1, 3, md3_decel, slidevert
      }

      dwindle {
          pseudotile = true
          preserve_split = true
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = -1
          disable_hyprland_logo = false
      }

      gestures {
          workspace_swipe = false
      }

      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }
    '';

    ".config/hypr/modules/rules.conf".text = ''
      windowrule = suppressevent maximize, class:.*
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';

    ".config/hypr/hyprpaper.conf".text = ''
      preload = /home/user/Pictures/Wallpapers/224390c925eb0d556d082f0c6d78a28f8ec27d51.jpg
      wallpaper = HDMI-A-3,/home/user/Pictures/Wallpapers/224390c925eb0d556d082f0c6d78a28f8ec27d51.jpg
    '';
  };
}
