{ pkgs, ... }: {
  imports = [
    ./shared/git.nix
    ./shared/terminal.nix
    ./shared/editors.nix
    ./shared/tools.nix
  ];

  home.packages = with pkgs; [
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      nr = "npm run";
      nddefault = "nix develop github:rfqma/multiverse";
      ndminimal = "nix develop github:rfqma/multiverse#minimal";
      ndcpp = "nix develop github:rfqma/multiverse#cpp";
      ndjs = "nix develop github:rfqma/multiverse#js";
      zed = "zeditor";
    };
    sessionVariables = {};

    initContent = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      eval "$(starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "[░▒▓](#a3aed2)\[  ](bg:#a3aed2 fg:#090c0c)\[](bg:#3b5280 fg:#a3aed2)\$directory\[](fg:#3b5280 bg:#394260)\$git_branch\$git_status\[](fg:#394260 bg:#212736)\$nodejs\$rust\$golang\$php\[](fg:#212736 bg:#1d2230)\$time\[ ](fg:#1d2230)\$nix_shell\$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold yellow)";
      };
      directory = {
        style = "fg:#e3e5e5 bg:#3b5280";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };
      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
      nodejs = {
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      php = {
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rust = {
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      python = {
        style = "bold yellow";
      };
      nix_shell = {
        style = "bold blue";
        heuristic = true;
      };
      docker_context = {
        style = "bold blue";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
      cmd_duration = {
        min_time = 2000;
        format = "[$duration](bold yellow)";
      };
    };
  };
}
