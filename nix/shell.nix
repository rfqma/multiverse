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
      echo "triggered a shell hook for a Nix development environment with C++."
      echo "❄️ welcome!"
    '';
  };
}
