{ inputs, pkgs, ... }:
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
    git-credential-manager
    tree-sitter
  ];

  store = with builtins; map (d: ./store/${d}) (attrNames (readDir ./store));
in
{
  userPackages = {
    atuin.enable = true;
    direnv.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    ssh.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    lang = {
      rust.enable = true;
      golang.enable = false;
      python.enable = true;
      haskell.enable = false;
      nodejs.enable = true;
      latex.enable = false;
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

  imports = store ++ [
    ../packages
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
