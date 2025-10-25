{
  description = "Rust development environment";

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
      overlays = [
        (import rust-overlay)
        (final: prev: {
          rustToolchain = prev.rust-bin.stable.latest.default;
        })
      ];

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
            pkgs = import nixpkgs { inherit overlays system; };
          }
        );
    in
    {
      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages =
              (with pkgs; [
                rustToolchain
              ])
              ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [ libiconv ]);
          };
        }
      );
    };
}
