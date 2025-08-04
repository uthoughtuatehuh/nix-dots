{ config, pkgs, ... }:
{
  xdg.configFile."hypr/scripts/switch_workspace.sh" = { 
    text = ''
      #!/usr/bin/env bash
      
      CURRENT_WS=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')
      
      if [ "$1" == "next" ]; then
        NEW_WS=$((CURRENT_WS + 1))
        if [ $NEW_WS -gt 10 ]; then
          NEW_WS=1
        fi
      elif [ "$1" == "prev" ]; then
        NEW_WS=$((CURRENT_WS - 1))
        if [ $NEW_WS -lt 1 ]; then
          NEW_WS=10
        fi
      else
        echo "Invalid argument. Use 'next' or 'prev'."
        exit 1
      fi
      
      hyprctl dispatch workspace $NEW_WS
    '';
    executable = true;
  };
}
