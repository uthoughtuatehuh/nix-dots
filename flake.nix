{
  description = "Моя NixOS конфигурация с Home Manager";

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
      url = "path:./modules/home/profiles/caelestia/caelestia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
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
  };

  outputs = { self, nixpkgs, home-manager, aagl-gtk-on-nix, nixcord, caelestia-shell, lanzaboote, disko }@inputs:

    let
      username = "user";
      homeDirectory = "/home/${username}";

      userConfig = {
        inherit username homeDirectory;
      };

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        localSystem = { inherit system; };
        config = {
          allowUnfree = true;
          # cudaSupport = true;
        };
        # overlays = [ ];
      };
      
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        specialArgs = { inherit inputs userConfig; };
        
        modules = [
          ./modules/system/configuration.nix
          aagl-gtk-on-nix.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          disko.nixosModules.disko

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [
              caelestia-shell.homeManagerModules.default
              nixcord.homeModules.nixcord
            ];
            home-manager.extraSpecialArgs = { inherit inputs userConfig; };
            home-manager.users.${username} = import ./modules/home/home.nix;
          }
        ];
      };
    };
}
