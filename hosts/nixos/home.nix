{ config, pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rfc-style
    fastfetch
    onefetch
    tokei
    ripgrep
    eza
    bat
    yarn
    nh
    helix
    xxd
    fzf
    fd
    silicon
    which
    tree
    btop
    dust
    duf
    comma
    rclone
    # wezterm
    typst
    pandoc
    exiftool
    adwaita-icon-theme
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
    ghostscript
    cloudtide.distrobox
    # tectonic
  ];
in
{
  userPackages = {
    fhs.enable = true;
    atuin.enable = true;
    secret.enable = true;
    direnv.enable = true;
    git.enable = true;
    tmux.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    emacs.enable = true;
    ssh.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    ghostty.enable = true;
    lang = {
      rust.enable = true;
      clangd.enable = true;
      golang.enable = true;
      python.enable = true;
      haskell.enable = true;
      frontend.enable = true;
      latex.enable = true;
      # moonbit.enable = true;
    };
  };

  home = {
    packages = packages;
    username = config.username;
    homeDirectory = "/home/${config.username}";
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

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  imports = [ ./shell.nix ];
}
