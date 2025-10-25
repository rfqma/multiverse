{
  description = "Rust example flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "https://flakehub.com/f/oxalica/rust-overlay/*";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
    }:
    let
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                rust-overlay.overlays.default
                self.overlays.default
              ];
            };
          }
        );
    in
    {
      overlays.default = final: prev: {
        rustToolchain = final.rust-bin.stable.latest.default;
      };

      packages = forAllSystems (
        { pkgs }:
        {
          default =
            let
              rustPlatform = pkgs.makeRustPlatform {
                cargo = pkgs.rustToolchain;
                rustc = pkgs.rustToolchain;
              };
            in
            rustPlatform.buildRustPackage {
              name = "rfqma-rust";
              src = ./.;
              cargoLock = {
                lockFile = ./Cargo.lock;
              };
            };
        }
      );
    };
}
