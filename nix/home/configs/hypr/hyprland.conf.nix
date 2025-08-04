{ config, pkgs, ... }:
{
  xdg.configFile."hypr/hyprland.conf".text = ''
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
}
