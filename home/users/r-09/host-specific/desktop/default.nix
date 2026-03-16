{ config, pkgs, inputs, ... }:
let
  enabledProfiles = [
    "hyprland/caelestia"
    # "hyprland/Ambxst"
    # "hyprland/waybar"
    "dwm/dwm"
    # "niri/DankMaterialShell"
  ];

  profileImports = map (profile: ./profiles + "/${profile}") enabledProfiles;
in {
  imports = [
    ./profiles/shared/default.nix
  ] ++ profileImports;
}
