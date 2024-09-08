{ pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rfc-style
    # alejandra
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
    wezterm
    typst
    pandoc
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
  ];
in
{
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
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "Bibata-Modern-Classic";
        gtk-theme = "WhiteSur-Dark";
        font-name = "Noto Sans CJK SC 14";
        document-font-name = "Noto Sans CJK SC 14";
        monospace-font-name = "IosevkaCloudtide Nerd Font 14";
      };
    };
  };

  imports = map (d: ./store + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./store)));

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
