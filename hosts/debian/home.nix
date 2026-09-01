{ config, pkgs, ... }:
{
  # mark this machine as a server to disable gpg signing in git
  server = true;
  xdg.enable = true;
  programs.fish.enable = true;
  home.username = config.username;
  home.homeDirectory = "/home/${config.username}";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nixfmt-rs
    lazydocker
    fastfetch
    fzf
    nh
    eza
    delta
    ripgrep
    rclone
    dust
    neovim
    nodejs_22
  ];
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    git.enable = true;
    zellij.enable = true;
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
