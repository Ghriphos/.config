{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

  };

  outputs = { self, nixpkgs, home-manager, noctalia, lanzaboote, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        noctalia.nixosModules.default
	lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
