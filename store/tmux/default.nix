{ pkgs, ... }:
let
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "320e184";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "320e184";
      sha256 = "sha256-gMBpINeHS+5TCsbJBHhXKEF+fG58FmJrIJoQWYdQqc0=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    terminal = "tmux-256color";
    mouse = true;
    prefix = "C-n";
    plugins = with pkgs; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @thm_surface_0 "#272E33"
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_current_number_color "#A7C080"
          set -g @catppuccin_window_status_style "basic"
          set -g @catppuccin_status_background "none"
        '';
      }
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = builtins.readFile ./tmux-cpu.conf;
      }
      tmuxPlugins.battery
      tmuxPlugins.cpu
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = ''
      unbind '"'
      unbind %
      set -sg escape-time 0
      set -g status-position top
      bind C-n select-window -n
      bind C-p select-window -p
      set-option -g focus-events on
      bind "'" splitw -v -c '#{pane_current_path}'
      bind ";" splitw -h -c '#{pane_current_path}' 
      set-option -sa terminal-features 'xterm-256color:RGB'
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded.."
    '';
  };
}
