{ config, pkgs, ... }:
{
  # mark this machine as a server to disable gpg signing in git
  server = true;
  xdg.enable = true;
  home.homeDirectory = "/home/${config.username}";
  home.username = config.username;
  programs.fish.enable = true;
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nixfmt-rfc-style
    lazydocker
    fastfetch
    fzf
    nh
    eza
    delta
    ripgrep
    rclone
    dust
    nvim
    nodejs_22
  ];
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    git.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    lang = {
      rust.enable = true;
    };
  };
  programs.man.generateCaches = false;
  programs.home-manager.enable = true;
}
