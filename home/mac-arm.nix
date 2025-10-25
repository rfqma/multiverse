{ pkgs, ... }: {
  imports = [
    ./shared/git.nix
    ./shared/shell.nix
    ./shared/terminal.nix
    ./shared/editors.nix
    ./shared/tools.nix
  ];

  home.packages = with pkgs; [
    tmux  # Ensure tmux is available system-wide
  ];

  # macOS-specific overrides can go here
  # For example, if you need different Ghostty settings for macOS
}
