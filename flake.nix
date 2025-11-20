{
  description = "multiverse";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:

    let
      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          }
        );
    in
    {
      # formatter
      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      devShells = forEachSupportedSystem (
        { pkgs, system }:
        let
          common = with pkgs; [
            gemini-cli
            self.formatter.${system}
          ];

          shell = import ./nix/shell.nix { inherit pkgs common; };
        in
        {
          inherit (shell)
            python
            go
            rust
            cpp
            nodejs
            laravel
            ;
        }
        // {
          default = pkgs.mkShellNoCC {
            packages = common;

            shellHook = ''
              echo "❄️ triggered a shell hook for a nix development environment"

              # launch zsh
              if [ -n "$ZSH_VERSION" ]; then
                # Already in zsh, do nothing
                :
              elif command -v zsh >/dev/null 2>&1; then
                # Launch zsh if available
                exec zsh
              fi
            '';
          };
        }
      );

      templates = {
        cpp-dev = {
          path = ./nix/templates/dev/cpp;
          description = "C++ dev environment template";
        };

        go-dev = {
          path = ./nix/templates/dev/go;
          description = "Go dev environment template";
        };

        nodejs-dev = {
          path = ./nix/templates/dev/nodejs;
          description = "Node.js dev environment template";
        };

        python-dev = {
          path = ./nix/templates/dev/python;
          description = "Python dev environment template";
        };

        rust-dev = {
          path = ./nix/templates/dev/rust;
          description = "Rust dev environment template";
        };

        cpp-pkg = {
          path = ./nix/templates/pkg/cpp;
          description = "C++ package starter template";
        };

        rust-pkg = {
          path = ./nix/templates/pkg/rust;
          description = "Rust package starter template";
        };
      };

      homeConfigurations = {
        "darwin-arm64" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./home/darwin-arm64.nix
            {
              home = {
                username = "rfqma";
                homeDirectory = "/Users/rfqma";
                stateVersion = "25.05";
              };
            }
          ];
        };

        "linux-x64" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./home/linux-x64.nix
            {
              home = {
                username = "rfqma";
                homeDirectory = "/home/rfqma";
                stateVersion = "25.05";
              };
            }
          ];
        };
      };
    };
}
