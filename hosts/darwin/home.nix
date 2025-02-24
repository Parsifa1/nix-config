{ pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rfc-style
    fastfetch
    onefetch
    tokei
    typst
    ripgrep
    eza
    bat
    yarn
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
    git-credential-manager
    nix-output-monitor
    ghostscript
    tectonic
  ];
in
{
  imports = [
    ./shell.nix
    ../../modules
  ];

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
    lang = {
      rust.enable = true;
      python.enable = true;
      nodejs.enable = true;
      moonbit.enable = true;
    };
  };

  home = {
    username = "parsifa1";
    homeDirectory = "/Users/parsifa1";
    packages = packages;
    file = {
      ".clang-format".source = ../.dotfile/.clang-format;
      ".clangd".text = import ../.dotfile/clangd.nix { inherit pkgs; };
      ".gnupg/gpg-agent.conf".text = ''
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
