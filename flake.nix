{
  description = "sidharth's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, playit-nixos-module, spicetify-nix }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit spicetify-nix; };
      system = "x86_64-linux";
      modules = [
        playit-nixos-module.nixosModules.default
        spicetify-nix.nixosModules.spicetify
        ./configuration.nix
      ];
    };

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        git gnupg gnutar gzip jq lzop python3 perl unzip wget xz zip zstd
        bc bison flex gawk gcc gnumake ccache lz4 ncurses ninja openssl
        pkg-config python3Packages.pycryptodome rsync screen socat udev
        android-tools which libxml2 libxslt file openjdk17
      ];

      shellHook = ''
        echo "Android build environment loaded!"
      '';
    };
  };
}
