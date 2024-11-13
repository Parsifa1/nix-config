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

  store = map (d: ./store + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./store)));
  public = map (d: ../packages + d) (
    map (n: "/" + n) (with builtins; attrNames (readDir ../packages))
  );
  global = store ++ public;
in
{
  home = {
    username = "parsifa1";
    homeDirectory = "/Users/parsifa1";
    packages = packages;
    file = {
      ".clang-format".source = ../.dotfile/.clang-format;
      ".clangd".text = import ../.dotfile/.clangd.nix {
        inherit pkgs;
        gcc = pkgs.gcc14;
      };
    };
  };

  imports = global ++ [
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
