{
  description = "C++ example flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
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
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      packages = forAllSystems (
        { pkgs }:
        {
          default =
            let
              binName = "rfqma-cpp";
              cppDependencies = with pkgs; [
                boost
                gcc
                poco
              ];
            in
            pkgs.stdenv.mkDerivation {
              name = "rfqma-cpp";
              src = self;
              buildInputs = cppDependencies;
              buildPhase = "c++ -std=c++17 -o ${binName} ${./main.cpp} -lPocoFoundation -lboost_system";
              installPhase = ''
                mkdir -p $out/bin
                cp ${binName} $out/bin/
              '';
            };
        }
      );
    };
}
