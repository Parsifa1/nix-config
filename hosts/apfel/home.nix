{ config, pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rfc-style
    nix-tree
    onefetch
    tokei
    typst
    ripgrep
    eza
    bat
    colmena
    websocat
    fontconfig
    nh
    delta
    fzf
    fd
    which
    tree
    btop
    dust
    duf
    comma
    silicon
    cloudtide.awrit
    zig
    # xmake
    exiftool
    git-credential-manager
    gh
    xld
    nix-output-monitor
    ghostscript
    tectonic
    neovide
    gnupg
    openssh
  ];
in
{
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    direnv.enable = true;
    tmux.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    ssh.enable = true;
    starship.enable = true;
    yazi.enable = true;
    ghostty.enable = true;
    zoxide.enable = true;
    fastfetch.enable = true;
    lang = {
      rust.enable = true;
      clang.enable = true;
      python.enable = true;
      frontend.enable = true;
    };
  };

  xdg.enable = true;
  home = {
    packages = packages;
    username = config.username;
    homeDirectory = "/Users/${config.username}";
    file = {
      ".gnupg/gpg-agent.conf".text =
        ''pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac'';
    };
  };

  programs.man.generateCaches = false;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [ ./shell.nix ];
}
