{ pkgs }:

with pkgs; [
  ngrok
  nodejs_22
  rustc
  rustfmt
  cargo
  go
  python312
  python312Packages.jupyterlab
  gemini-cli
]
