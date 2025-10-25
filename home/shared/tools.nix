{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Container tools
    podman
    podman-compose

    # Archive tools
    p7zip          # 7zip

    # Additional useful tools
    tree           # Directory tree view
    htop           # Better top
    curl           # HTTP client
    wget           # File downloader
    jq             # JSON processor
  ];
}
