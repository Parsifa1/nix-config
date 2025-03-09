{ config, pkgs, ... }:
{
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      pinentry-program ${pkgs.pinentry-curses}/bin/pinentry
    '';
  };
  home.homeDirectory = "/home/${config.username}";
  programs.fish.enable = true;
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nixfmt-rfc-style
    fastfetch
    fzf
    nh
    eza
    delta
    agenix
    ripgrep
    rclone
    rustup
    yazi
    nixd
    dust
    nvim
  ];
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    git.enable = true;
    tmux.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
  imports = [ ./shell.nix ];
  programs.home-manager.enable = true;
}
