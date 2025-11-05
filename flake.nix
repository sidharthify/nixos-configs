{
  description = "sidharth's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser-source.url = "github:youwen5/zen-browser-flake";
    nixcord.url = "github:KaylorBen/nixcord";
    lazyvim-nix.url = "github:jla2000/lazyvim-nix";
    syd.url = "github:sidharthify/syd";
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, zen-browser-source, nixcord, lazyvim-nix, syd, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.sidharthify = import ./home-manager/home.nix;

            home-manager.sharedModules = [
              nixcord.homeModules.nixcord
            ];

            home-manager.extraSpecialArgs = {
              inherit spicetify-nix lazyvim-nix;
            };
          }

          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              zen-browser-source.packages.${system}.default
              syd.packages.${system}.default
            ];
          })
        ];
      };
  };
}
