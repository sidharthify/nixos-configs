{
  description = "siddhi's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser-source.url = "github:youwen5/zen-browser-flake";
    nixcord.url = "github:KaylorBen/nixcord";
    lazyvim-nix.url = "github:jla2000/lazyvim-nix";

    syd.url = "github:sidharthify/syd";
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, zen-browser-source, nixcord, lazyvim-nix, syd, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./nixos/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.sidharthify = import ./home/home.nix;

          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
          ];

          home-manager.extraSpecialArgs = {
            inherit spicetify-nix lazyvim-nix;
          };
        }

        {
          environment.systemPackages = [
            zen-browser-source.packages.${system}.default
            syd.packages.${system}.default
          ];
        }
      ];
    };
  };
}
