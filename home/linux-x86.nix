{ pkgs, ... }: {
  imports = [
    ./shared/git.nix
    ./shared/shell.nix
    ./shared/terminal.nix
    ./shared/editors.nix
    ./shared/tools.nix
  ];

  home.packages = with pkgs; [
    tmux
    bitwarden-desktop
    spotify
    discord
    whatsapp-electron
    telegram-desktop
  ];

  # Linux-specific overrides can go here
  # For example, different keybindings or themes
}
