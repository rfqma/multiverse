{ pkgs, ... }:

{
  home.packages = with pkgs; [
    podman
    podman-compose
    p7zip
    tree           # Directory tree view
    htop           # Better top
    curl           # HTTP client
    wget           # File downloader
    jq             # JSON processor
  ];
}
