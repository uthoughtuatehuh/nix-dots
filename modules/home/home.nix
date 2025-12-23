{ config, pkgs, inputs, userConfig, ... }:
let
  enabledProfiles = [
    "caelestia"
    # "waybar"
    "shared" 
  ];
  
  profileImports = map (profile: ./profiles + "/${profile}/default.nix") enabledProfiles;
in {
  imports = [
    ./default.nix
  ] ++ profileImports;

  home.username = userConfig.username;
  home.homeDirectory = userConfig.homeDirectory;
  home.stateVersion = "25.05";
}
