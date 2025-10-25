{ pkgs }:

{
  minimal = pkgs.mkShell {
    name = "multiverse";

    packages = with pkgs; [
      nodejs
      rustc
      rustfmt
      cargo
      go
      python312
      python312Packages.jupyterlab
    ];

    WHERE_AM_I = "in the multiverse!";

    shellHook = ''
        # launch zsh
        if [ -n "$ZSH_VERSION" ]; then
          # Already in zsh, do nothing
          :
        elif command -v zsh >/dev/null 2>&1; then
          # Launch zsh if available
          exec zsh
        fi

      echo "triggered a shell hook for a Nix development environment."
      echo "❄️ welcome!"
    '';
  };

  cpp = pkgs.mkShell {
    packages = with pkgs; [
      gcc
      cmake
    ];

    shellHook = ''
        # launch zsh
        if [ -n "$ZSH_VERSION" ]; then
          # Already in zsh, do nothing
          :
        elif command -v zsh >/dev/null 2>&1; then
          # Launch zsh if available
          exec zsh
        fi

      echo "triggered a shell hook for a Nix development environment with C++."
      echo "❄️ welcome!"
    '';
  };
}
