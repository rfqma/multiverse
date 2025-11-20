{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;
  };

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
      "nvim-nightfox"
    ];
    userKeymaps = [
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
            context_servers = { };
          };
        };
        default_profile = "ask";
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
        model_parameters = [ ];
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
        light = "Catppuccin Frappé";
        dark = "Catppuccin Frappé";
      };
      ui_font_size = 12.0;
      buffer_font_size = 11.0;
      theme = {
        mode = "system";
        light = "Carbonfox - blurred";
        dark = "Carbonfox - blurred";
      };
    };
  };
}
