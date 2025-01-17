{ pkgs, ... }:
{
  home.username = "parsifa1";
  home.homeDirectory = "/home/parsifa1";
  programs.fish.enable = true;
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nixfmt-rfc-style
    fastfetch
    fzf
    nh
    eza
    delta
    ripgrep
    rclone
    yazi
    nixd
    dust
    neovim
  ];
  userPackages = {
    atuin.enable = true;
    git.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
  imports = [ ./shell.nix ];
  programs.home-manager.enable = true;
}
