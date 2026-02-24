{
  description = "My multi-host NixOS + Home-Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl-gtk-on-nix = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "path:./pkgs/caelestia-shell";
      # url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      
      user = "quanve";

      mkNixos = hostname: system: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self user; };

        modules = lib.flatten [
          ./hosts/common
          (./hosts + "/${hostname}")

          inputs.aagl-gtk-on-nix.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.disko.nixosModules.disko

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs     = true;
              useUserPackages   = true;
              backupFileExtension = "hm-bak";

              sharedModules = [
                inputs.caelestia-shell.homeManagerModules.default
                inputs.nixcord.homeModules.nixcord
                inputs.nixvim.homeModules.nixvim
              ];

              extraSpecialArgs = { inherit inputs self user; };

              users.${user} = {
                imports = [
                  ./home/common
                  ./home/users/${user}
                  (./home/users/${user}/host-specific + "/${hostname}")
                ];
                home.stateVersion = "25.05";
              };
            };
          }

          extraModules
        ];
      };

    in {
      nixosConfigurations = {
        desktop = mkNixos "desktop" "x86_64-linux" [];
        test   = mkNixos "test"   "x86_64-linux" [];
        # laptop  = mkNixos "laptop"  "x86_64-linux" [];
      };

      # standalone home-manager
      homeConfigurations."${user}@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs self user; };
        modules = [
          ./home/common
          ./home/users/${user}
          ./home/users/${user}/host-specific/framework.nix
        ];
      };
    };
}
