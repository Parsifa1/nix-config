{ pkgs, ... }:
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
    git-credential-manager
    tree-sitter
  ];

  store = with builtins; map (d: ./store/${d}) (attrNames (readDir ./store));
  public = with builtins; map (d: ../packages/${d}) (attrNames (readDir ../packages));
  global = store ++ public;
in
{
  home = {
    username = "parsifa1";
    homeDirectory = "/Users/parsifa1";
    packages = packages;
    file = {
      ".clang-format".source = ../.dotfile/.clang-format;
      ".clangd".text = import ../.dotfile/.clangd.nix { inherit pkgs; };
    };
  };

  imports = global ++ [ ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
