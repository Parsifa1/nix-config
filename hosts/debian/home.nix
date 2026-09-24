{ config, pkgs, ... }:
{
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
    zellij.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    git = {
      enable = true;
      gpgSign = false;
    };
    yazi = {
      enable = true;
      compact = true;
    };
    lang = {
      rust.enable = true;
    };
  };
  programs.man.generateCaches = false;
  programs.home-manager.enable = true;
}
