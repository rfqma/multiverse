{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Container tools
    podman
    podman-compose

    # Archive tools
    p7zip          # 7zip
    unzip          # .zip files
    zip            # create .zip files
    unrar          # .rar files
    gnutar         # .tar files
    gzip           # .gz files
    bzip2          # .bz2 files
    xz             # .xz files

    # Additional useful tools
    tree           # Directory tree view
    htop           # Better top
    curl           # HTTP client
    wget           # File downloader
    jq             # JSON processor
  ];
}
