{ pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    shortcut = "a"; # Sets prefix to C-a
    terminal = "screen-256color";
    extraConfig = ''
      # sensible defaults
      set -g history-limit 50000
      set -sg escape-time 0
      set -g focus-events on

      # status bar customization
      set -g status-position top
      set -g status-style 'bg=default,fg=blue'
      set -g status-left ''
      set -g status-right '#[fg=yellow,bold]%Y-%m-%d %H:%M'
      set -g window-status-current-format '#[bold,fg=green] #I: #W '
      set -g window-status-format '#[fg=gray] #I: #W '
    '';
  };

  # Ghostty config - will be overridden with platform-specific settings
  home.file.".config/ghostty/config".text = ''
    title = 👻
    font-size = 14
    theme = 0x96f
    shell-integration-features = no-cursor,sudo
    background-opacity = 0.92
    cursor-style = block
    mouse-hide-while-typing = true
    window-save-state = "always"

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
    ${lib.optionalString pkgs.stdenv.isDarwin ''
      macos-titlebar-style = "transparent"
    ''}
    ${lib.optionalString pkgs.stdenv.isLinux ''
      # Linux-specific settings can go here
    ''}
  '';
}
