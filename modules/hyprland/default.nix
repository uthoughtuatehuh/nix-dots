{ config, pkgs, lib, ... }:

let
  hyprlandConfig = ''
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

  generalConf = ''
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

  execsConf = ''
    exec-once = waybar
    exec-once = hyprpaper
  '';

  envConf = ''
    env = XCURSOR_THEME, Bibata-Modern-Classic
    env = HYPRCURSOR_SIZE,24
  '';

  keybindsConf = ''
    $terminal = kitty
    $fileManager = dolphin
    $menu = rofi -show drun
    $mainMod = SUPER

    bind = $mainMod, RETURN, exec, $terminal
    bind = $mainMod, C, killactive,
    bind = $mainMod, DELETE, exit,
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, SPACE, togglefloating,
    bind = $mainMod, D, exec, $menu
    bind = $mainMod SHIFT, F, exec, firefox
    bind = $mainMod, J, togglesplit,

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

  rulesConf = ''
    windowrule = suppressevent maximize, class:.*
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  '';

  variablesConf = ''
    $terminal = kitty
    $fileManager = dolphin
    $menu = rofi -show drun
    $mainMod = SUPER
  '';

  hyprlockConf = ''
    $text_color = rgba(E6DEFFFF)
    $entry_background_color = rgba(1C006211)
    $entry_border_color = rgba(938E9F55)
    $entry_color = rgba(E6DEFFFF)
    $font_family = Rubik Light
    $font_family_clock = Rubik Light
    $font_material_symbols = Material Symbols Rounded

    background {
      color = rgba(181818FF)
    }

    input-field {
      monitor =
      size = 250, 50
      outline_thickness = 2
      dots_size = 0.1
      dots_spacing = 0.3
      outer_color = $entry_border_color
      inner_color = $entry_background_color
      font_color = $entry_color
      fade_on_empty = true
      position = 0, 20
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $TIME
      color = $text_color
      font_size = 65
      font_family = $font_family_clock
      position = 0, 300
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:5000] date +"%A, %B %d"
      color = $text_color
      font_size = 17
      font_family = $font_family
      position = 0, 240
      halign = center
      valign = center
    }

    label {
      monitor =
      text =     $USER
      color = $text_color
      shadow_passes = 1
      shadow_boost = 0.35
      outline_thickness = 2
      font_size = 20
      font_family = $font_family
      position = 0, 50
      halign = center
      valign = bottom
    }

    label {
      monitor =
      text = cmd[update:5000] ${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/status.sh
      color = $text_color
      font_size = 14
      font_family = $font_family
      position = 30, -30
      halign = left
      valign = top
    }
  '';

  hyprpaperConf = ''
    preload = /home/user/Pictures/Wallpapers/lock_screen.png
    wallpaper = HDMI-A-3, /home/user/Pictures/Wallpapers/lock_screen.png
  '';

  switchWorkspaceScript = ''
    #!/usr/bin/env bash
    CURRENT_WS=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')
    if [ "$1" == "next" ]; then
      NEW_WS=$((CURRENT_WS + 1))
      if [ $NEW_WS -gt 10 ]; then NEW_WS=1; fi
    elif [ "$1" == "prev" ]; then
      NEW_WS=$((CURRENT_WS - 1))
      if [ $NEW_WS -lt 1 ]; then NEW_WS=10; fi
    else
      echo "Invalid argument. Use 'next' or 'prev'."
      exit 1
    fi
    hyprctl dispatch workspace $NEW_WS
  '';
in {
  xdg.configFile = {
    "hypr/hyprland.conf".text = hyprlandConfig;
    "hypr/hyprpaper.conf".text = hyprpaperConf;
    "hypr/hyprlock.conf".text = hyprlockConf;
    
    "hypr/modules/general.conf".text = generalConf;
    "hypr/modules/execs.conf".text = execsConf;
    "hypr/modules/env.conf".text = envConf;
    "hypr/modules/keybinds.conf".text = keybindsConf;
    "hypr/modules/rules.conf".text = rulesConf;
    "hypr/modules/variables.conf".text = variablesConf;

    "hypr/scripts/switch_workspace.sh" = {
      text = switchWorkspaceScript;
      executable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    hyprlock
    grim
    slurp
    wl-clipboard
    ydotool
    playerctl
    brightnessctl
    wl-clipboard
    cliphist
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };
}
