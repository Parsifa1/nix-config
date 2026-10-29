{ config, pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rs
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
    sops
    fzf
    fd
    jq
    which
    tree
    btop
    dust
    duf
    comma
    silicon
    zig
    cmake
    ninja
    mosh
    exiftool
    gh
    xld
    lazydocker
    ssh-to-age
    ghostscript
    tectonic
    neovide
    gnupg
    openssh
    colima
    docker
    nix-output-monitor
    git-credential-manager
    docker-credential-helpers
  ];
in
{
  userPackages = {
    atuin.enable = true;
    secret.enable = true;
    agent.enable = true;
    direnv.enable = true;
    zellij.enable = true;
    git = {
      enable = true;
      credentialHelper = "osxkeychain";
    };
    lazygit.enable = true;
    neovim.enable = true;
    ssh.enable = true;
    starship.enable = true;
    yazi.enable = true;
    ghostty.enable = true;
    zoxide.enable = true;
    fastfetch.enable = true;
    herdr.enable = true;
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
      "/.local/share/gnupg/gpg-agent.conf".text =
        "pinentry-program /usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac";
    };
  };

  programs.man.generateCaches = false;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [ ./shell.nix ];
}
