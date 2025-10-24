{ config, pkgs, ... }:

{
  home.username = "rfqma";
  home.homeDirectory = "/Users/rfqma";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    git
    # ghostty
    # podman
    # podman-compose
    # vscode
    # zed-editor
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      nr = "npm run";
      ndzsh = "nix develop github:rfqma/multiverse --command zsh";
    };
    sessionVariables = {};

    initContent = ''
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

  programs.git = {
    enable = true;
    userName = "rfqma";
    userEmail = "abelcaster025@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  home.file.".config/ghostty/config".text = ''
    title = 👻
    font-size = 14
    theme = 0x96f
    shell-integration-features = no-cursor,sudo
    background-opacity = 0.92
    cursor-style = block
    mouse-hide-while-typing = true
    window-save-state = "always"
    macos-titlebar-style = "transparent"

    # keybindings
    keybind = cmd+s>r=reload_config
    keybind = cmd+s>x=close_surface
    keybind = cmd+s>n=new_window
    # tabs
    keybind = cmd+s>c=new_tab
    keybind = cmd+s>shift+l=next_tab
    keybind = cmd+s>shift+h=previous_tab
    keybind = cmd+s>comma=move_tab:-1
    keybind = cmd+s>period=move_tab:1
    # quick tab switch
    keybind = cmd+s>1=goto_tab:1
    keybind = cmd+s>2=goto_tab:2
    keybind = cmd+s>3=goto_tab:3
    keybind = cmd+s>4=goto_tab:4
    keybind = cmd+s>5=goto_tab:5
    keybind = cmd+s>6=goto_tab:6
    keybind = cmd+s>7=goto_tab:7
    keybind = cmd+s>8=goto_tab:8
    keybind = cmd+s>9=goto_tab:9
    # split
    keybind = cmd+s>\=new_split:right
    keybind = cmd+s>-=new_split:down
    keybind = cmd+s>j=goto_split:bottom
    keybind = cmd+s>k=goto_split:top
    keybind = cmd+s>h=goto_split:left
    keybind = cmd+s>l=goto_split:right
    keybind = cmd+s>z=toggle_split_zoom
    keybind = cmd+s>e=equalize_splits
    # other
    copy-on-select = clipboard
  '';

  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "dockerfile"
      "catppuccin-icons"
      "emmet"
      "prisma"
      "docker-compose"
      "nix"
      "rainbow-csv"
      "marksman"
      "react-typescript-snippets"
      "python-snippets"
      "mcp-server-figma"
      "matte-black"
    ];
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          # "shift shift": "file_finder::Toggle"
        };
      }
      {
        context = "Editor && vim_mode == insert";
        bindings = {
          # "j k": "vim::NormalBefore"
        };
      }
      {
        context = "Workspace";
        bindings = {
          cmd-shift-g = "git_panel::ToggleFocus";
        };
      }
    ];
    userSettings = {
      terminal = {
        toolbar = {
          breadcrumbs = true;
        };
      };
      ui_font_family = ".ZedMono";
      buffer_font_family = ".ZedMono";
      buffer_font_weight = 400.0;
      agent_buffer_font_size = 11.0;
      agent_ui_font_size = 14.0;
      context_servers = {
        "mcp-server-figma" = {
          source = "extension";
          enabled = true;
          settings = {
            figma_api_key = "$FIGMA_API_KEY"; # set this inside editor
          };
        };
      };
      agent = {
        profiles = {
          write = {
            name = "Write";
            tools = {
              copy_path = true;
              create_directory = true;
              delete_path = true;
              diagnostics = true;
              edit_file = true;
              fetch = true;
              list_directory = true;
              project_notifications = true;
              move_path = true;
              now = true;
              find_path = true;
              read_file = true;
              grep = true;
              terminal = true;
              thinking = true;
              web_search = true;
              open = true;
            };
            enable_all_context_servers = true;
            context_servers = {};
          };
        };
        default_profile = "ask";
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
        model_parameters = [];
      };
      minimap = {
        show = "never";
      };
      inlay_hints = {
        enabled = true;
        show_value_hints = true;
        show_type_hints = false;
        show_parameter_hints = true;
        show_other_hints = true;
        show_background = false;
        edit_debounce_ms = 500;
        scroll_debounce_ms = 50;
        toggle_on_modifiers_press = {
          control = false;
          alt = false;
          shift = false;
          platform = false;
          function = false;
        };
      };
      buffer_font_features = {
        calt = 1;
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      icon_theme = {
        mode = "system";
        # light = "Zed (Default)";
        light = "Catppuccin Frappé";
        dark = "Catppuccin Frappé";
      };
      ui_font_size = 12.0;
      buffer_font_size = 11.0;
      theme = {
        mode = "system";
        light = "Matte Black";
        dark = "Matte Black";
      };
    };
  };
}
