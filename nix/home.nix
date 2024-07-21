{pkgs, ...}: let
  packages = with pkgs; [
    fastfetch
    onefetch
    tokei
    ripgrep
    eza
    bat
    yarn
    nh
    helix
    delta
    fzf
    fd
    which
    tree
    btop
    dust
    duf
    alejandra
    typst
    pandoc
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
  ];
in {
  home = {
    username = "parsifa1";
    homeDirectory = "/home/parsifa1";
    packages = packages;
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  imports = map (d: ./store + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./store)));

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
