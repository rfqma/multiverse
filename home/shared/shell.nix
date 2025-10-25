{ ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      nr = "npm run";
      nd = "nix develop github:rfqma/multiverse";
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
    };
    sessionVariables = {};

    initExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      if [ -n "$IN_ISOLATED_SHELL" ]; then
        export GOPATH="$NIX_HOME/go"
        export CARGO_HOME="$NIX_HOME/.cargo"
        export PATH="$NIX_HOME/.local/bin:$PATH"
      else
        export GOPATH="$HOME/.nix/go"
        export CARGO_HOME="$HOME/.nix/.cargo"
        export PATH="$HOME/.local/bin:$PATH"
      fi

      eval "$(starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$all$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold yellow)";
      };
      directory = {
        style = "blue bold";
        truncate_to_repo = true;
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        style = "yellow";
      };
      git_status = {
        style = "red";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        conflicted = "🏳";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++\($count\)](green)";
        renamed = "👅";
        deleted = "🗑";
      };
      nodejs = {
        style = "bold green";
      };
      python = {
        style = "bold yellow";
      };
      rust = {
        style = "bold red";
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
        style = "bold white";
        format = "[$time]($style) ";
      };
      cmd_duration = {
        min_time = 2000;
        format = "[$duration](bold yellow) ";
      };
    };
  };
}
