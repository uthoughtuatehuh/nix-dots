{ config, pkgs, inputs, ... }:
let
  enabledProfiles = [
    "caelestia"
    # "waybar"
    "shared" 
  ];
  
  profileImports = map (profile: ./profiles + "/${profile}/default.nix") enabledProfiles;
in {
  imports = [
    ./home/packages.nix
    ./home/desktop.nix
  ] ++ profileImports;

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";
}
