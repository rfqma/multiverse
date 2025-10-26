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
  ];

  # Linux-specific overrides can go here
  # For example, different keybindings or themes
}
