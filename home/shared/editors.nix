{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # File explorer
      nvim-tree-lua
      # Status line (bottom bar with info)
      lualine-nvim
      # Fuzzy finder (Ctrl+P equivalent)
      telescope-nvim
      plenary-nvim  # Required by telescope
      # Syntax highlighting
      nvim-treesitter.withAllGrammars
      # Color scheme
      tokyonight-nvim
      # Auto-completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      # LSP (Language Server Protocol)
      nvim-lspconfig
      # Git integration
      gitsigns-nvim
      # Auto pairs (brackets, quotes)
      nvim-autopairs
      # Comment toggling
      comment-nvim
      # Which-key (shows available keybindings)
      which-key-nvim
      # Icons (for nvim-tree and others)
      nvim-web-devicons
    ];
    extraLuaConfig = ''
      -- Basic Settings
      vim.opt.number = true          -- Show line numbers
      vim.opt.relativenumber = true  -- Show relative line numbers
      vim.opt.mouse = 'a'            -- Enable mouse
      vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
      vim.opt.tabstop = 2            -- Tab width
      vim.opt.shiftwidth = 2         -- Indent width
      vim.opt.expandtab = true       -- Use spaces instead of tabs
      vim.opt.wrap = false           -- Don't wrap lines
      vim.opt.cursorline = true      -- Highlight current line
      vim.opt.termguicolors = true   -- True color support
      -- Set leader key (like Ctrl in VSCode shortcuts)
      vim.g.mapleader = " "  -- Space as leader key
      -- Color scheme
      require('tokyonight').setup({
        style = "night",
        transparent = false,
      })
      vim.cmd([[colorscheme tokyonight]])
      -- Status line
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        }
      })
      -- File explorer
      require('nvim-tree').setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
      })
      -- Telescope (fuzzy finder)
      require('telescope').setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = " ",
        }
      })
      -- Treesitter (syntax highlighting)
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
      })
      -- Auto-completion
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      -- LSP setup for common languages
      local lspconfig = require('lspconfig')

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({})
      -- Python
      lspconfig.pyright.setup({})
      -- Go
      lspconfig.gopls.setup({})
      -- Rust
      lspconfig.rust_analyzer.setup({})
      -- Git signs
      require('gitsigns').setup()
      -- Auto pairs
      require('nvim-autopairs').setup({})
      -- Comment
      require('Comment').setup()
      -- Which-key
      require('which-key').setup({})
      -- Key mappings (shortcuts)
      local keymap = vim.keymap.set
      -- File explorer
      keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
      -- Telescope
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
      -- Save file
      keymap('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
      -- Quit
      keymap('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
      -- Split windows
      keymap('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split vertically' })
      keymap('n', '<leader>sh', ':split<CR>', { desc = 'Split horizontally' })
    '';
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
      "matte-black"
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

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        bradlc.vscode-tailwindcss
        christian-kohler.npm-intellisense
        christian-kohler.path-intellisense
        eamodio.gitlens
        ecmel.vscode-html-css
        github.copilot
        github.copilot-chat
        github.github-vscode-theme
        github.vscode-github-actions
        golang.go
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        pkief.material-icon-theme
        shd101wyy.markdown-preview-enhanced
        svelte.svelte-vscode
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Extensions that aren't in nixpkgs yet
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.rulers" = [80];
          "editor.selectionHighlight" = false;
          "editor.suggest.snippetsPreventQuickSuggestions" = false;
          "editor.suggestSelection" = "first";
          "editor.tabCompletion" = "onlySnippets";
          "editor.wordBasedSuggestions" = "off";
        };
        "[go]" = {
          "editor.insertSpaces" = false;
          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.organizeImports" = "explicit";
          };
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "tailwindCSS.includeLanguages" = {
          "html" = "html";
          "javascript" = "javascript";
          "css" = "css";
        };
        "editor.quickSuggestions" = {
          "strings" = true;
        };
        "editor.accessibilitySupport" = "off";
        "editor.fontFamily" = "'Liga SFMono Nerd Font'";
        "editor.fontWeight" = "400";
        "editor.fontLigatures" = false;
        "editor.letterSpacing" = 0.3;
        "editor.lineHeight" = 1.5;
        "editor.fontSize" = 13;
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnPaste" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "terminal.integrated.fontFamily" = "'Liga SFMono Nerd Font'";
        "terminal.integrated.env.osx" = {};
        "terminal.integrated.env.linux" = {};
        "terminal.integrated.env.windows" = {};
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "GitHub Dark Dimmed";
        "workbench.editor.empty.hint" = "hidden";
        "workbench.editorAssociations" = {
          "*.docx" = "default";
        };
        "emmet.includeLanguages" = {
          "javascript" = "javascriptreact";
          "typescript" = "typescriptreact";
        };
        "css.lint.unknownAtRules" = "ignore";
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "notebook.cellFocusIndicator" = "border";
        "notebook.formatOnSave.enabled" = true;
        "notebook.output.scrolling" = true;
        "notebook.output.textLineLimit" = 100;
        "git.autofetch" = true;
        "remote.autoForwardPortsSource" = "hybrid";
        "solidity.telemetry" = true;
        "chat.mcp.discovery.enabled" = {
          "claude-desktop" = true;
          "windsurf" = true;
          "cursor-global" = true;
          "cursor-workspace" = true;
        };
        "chat.agent.enabled" = true;
        "chat.mcp.access" = "all";
        "chat.mcp.serverSampling" = {
          "Global in Code: Figma MCP" = {
            "allowedModels" = ["copilot/claude-sonnet-4.5"];
          };
        };
        "svelte.enable-ts-plugin" = true;
        "github.copilot.nextEditSuggestions.enabled" = true;
        "gitlens.ai.model" = "vscode";
        "gitlens.ai.vscode.model" = "copilot:gpt-4.1";
      };
    };
  };
}
