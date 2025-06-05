{
  description = "sidharth's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser-source.url = "github:youwen5/zen-browser-flake";
    nixcord.url = "github:KaylorBen/nixcord";
  };

  outputs = { self, nixpkgs, playit-nixos-module, spicetify-nix, zen-browser-source, home-manager, nixcord, ... }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit spicetify-nix;
      };
      system = "x86_64-linux";
      modules = [
        playit-nixos-module.nixosModules.default
        spicetify-nix.nixosModules.spicetify
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sidharthify = import ./home.nix;
          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
          ];
        }
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            zen-browser-source.packages.x86_64-linux.default
          ];
        })
      ];
    };
  };
}
