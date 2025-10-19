{
  description = "multiverse";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
  let
    supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
  in
  flake-utils.lib.eachSystem supportedSystems (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      common = import ./modules/base.nix { inherit pkgs; };
      osSpecific = import (
        if pkgs.stdenv.isDarwin
        then ./modules/mac.nix
        else ./modules/linux.nix
      ) { inherit pkgs; };

    in {
      devShells.default = pkgs.mkShell {
        name = "dev-shell";
        buildInputs = common ++ osSpecific;
        shellHook = ''
          export HOME=~
          export IN_ISOLATED_SHELL=true
          mkdir -p ~/.nix/home
          export NIX_HOME=~/.nix/home
          echo "❄️ welcome (${system})"
        '';
      };
    }
  )
  // {
    homeConfigurations.mac = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      modules = [ ./home/mac.nix ];
    };

    homeConfigurations.linux = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [ ./home/linux.nix ];
    };
  };
}
