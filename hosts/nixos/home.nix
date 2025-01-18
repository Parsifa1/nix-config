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
    fzf
    fd
    silicon
    which
    tree
    btop
    dust
    duf
    comma
    # wezterm
    typst
    pandoc
    exiftool
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
    # ghostty
  ];
in
{
  imports = [ ./shell.nix ];

  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    direnv.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    emacs.enable = true;
    ssh.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    lang = {
      rust.enable = true;
      golang.enable = true;
      python.enable = true;
      haskell.enable = true;
      nodejs.enable = true;
      latex.enable = true;
      moonbit.enable = true;
    };
  };

  home = {
    username = "parsifa1";
    homeDirectory = "/home/parsifa1";
    file.".clang-format".source = ../.dotfile/.clang-format;
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

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
