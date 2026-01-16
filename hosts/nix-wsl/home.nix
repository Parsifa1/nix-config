{ config, pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt
    # fastfetch
    onefetch
    tokei
    ripgrep
    eza
    bat
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
    koka
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
    fastfetch.enable = true;
    lang = {
      rust.enable = true;
      clang.enable = true;
      golang.enable = true;
      python.enable = true;
      haskell.enable = true;
      frontend.enable = true;
      latex.enable = true;
      # moonbit.enable = true;
    };
  };

  xdg.enable = true;
  home = {
    packages = packages;
    username = config.username;
    homeDirectory = "/home/${config.username}";
  };

  gtk = {
    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.config/gtk-2.0/gtkrc";
    };
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

  programs.man.generateCaches = false;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  imports = [ ./shell.nix ];
}
