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

  home.activation.linkApplications = pkgs.lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "linking gui applications..."
    $DRY_RUN_CMD mkdir -p ~/Applications/Home\ Manager\ Apps

    # zed
    if [ -d "${pkgs.zed-editor}/Applications/Zed.app" ]; then
      $DRY_RUN_CMD ln -sf "${pkgs.zed-editor}/Applications/Zed.app" ~/Applications/Home\ Manager\ Apps/
    fi

    # vscode
    if [ -d "${pkgs.vscode}/Applications/Visual Studio Code.app" ]; then
      $DRY_RUN_CMD ln -sf "${pkgs.vscode}/Applications/Visual Studio Code.app" ~/Applications/Home\ Manager\ Apps/
    fi
  '';

  # macOS-specific overrides can go here
  # For example, if different Ghostty settings for macOS needed
}
