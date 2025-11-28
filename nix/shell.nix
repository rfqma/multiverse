{
  pkgs,
  common ? [ ],
}:

{
  python = pkgs.mkShell {
    name = "python";

    packages =
      with pkgs;
      [
        python312
        python312Packages.jupyterlab
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with python"

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

  go = pkgs.mkShell {
    name = "go";

    packages =
      with pkgs;
      [
        go
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with go"

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

  rust = pkgs.mkShell {
    name = "rust";

    packages =
      with pkgs;
      [
        rustc
        rustfmt
        cargo
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with rust"

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

  cpp = pkgs.mkShell {
    name = "cpp";

    packages =
      with pkgs;
      [
        gcc
        cmake
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with c++"

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

  nodejs = pkgs.mkShell {
    name = "nodejs";

    packages =
      with pkgs;
      [
        nodejs
        pnpm
        bun
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with nodejs"

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

  laravel = pkgs.mkShell {
    name = "laravel";

    packages =
      with pkgs;
      [
        nodejs
        php84
        php84Packages.composer
      ]
      ++ common;

    shellHook = ''
      echo "❄️ triggered a shell hook for a nix development environment with laravel"

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
