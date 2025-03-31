{ config, pkgs, ... }:
{
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
    agenix
    ripgrep
    rclone
    dust
    nvim
  ];
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    git-debian.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    lang = {
      rust.enable = true;
    };
  };
  programs.home-manager.enable = true;
}
