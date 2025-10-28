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

  programs.zsh = {
    enable = true;
    shellAliases = {
      nr = "npm run";
      nddefault = "nix develop github:rfqma/multiverse";
      ndminimal = "nix develop github:rfqma/multiverse#minimal";
      ndcpp = "nix develop github:rfqma/multiverse#cpp";
      ndjs = "nix develop github:rfqma/multiverse#js";
      zed = "zeditor"
    };
    sessionVariables = {};

    initContent = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      eval "$(starship init zsh)"
    '';
  };
}
